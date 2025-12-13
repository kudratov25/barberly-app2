# Backend: Bir vaqtga faqat bir booking qilish uchun qo'llanma

## Muammo
Bir xil barber uchun bir xil vaqt slotiga bir nechta booking qilish mumkin bo'lishi kerak emas. Frontend tomonida mavjud orderlarni tekshirib, band bo'lgan slotlarni filtrlash amalga oshirildi, lekin bu yetarli emas. Backend tomonida ham qo'shimcha tekshiruvlar qo'shish kerak.

## Yechim

### 1. Order yaratishda tekshiruv (POST /api/v1/orders)

`OrderController@store()` metodida quyidagi tekshiruvlarni qo'shing:

```php
public function store(Request $request)
{
    $validated = $request->validate([
        'barber_id' => 'required|exists:users,id',
        'service_id' => 'required_without:service_ids|exists:services,id',
        'service_ids' => 'required_without:service_id|array',
        'service_ids.*' => 'exists:services,id',
        'start_time' => 'required|date|after:now',
    ]);

    $barberId = $validated['barber_id'];
    $startTime = Carbon::parse($validated['start_time']);
    
    // Xizmatlar davomiyligini hisoblash
    $serviceIds = $validated['service_ids'] ?? [$validated['service_id']];
    $totalDuration = Service::whereIn('id', $serviceIds)->sum('duration_minutes');
    $endTime = $startTime->copy()->addMinutes($totalDuration);

    // Bu vaqt slotida mavjud bookinglarni tekshirish
    $conflictingOrders = Order::where('barber_id', $barberId)
        ->whereIn('status', ['pending', 'in_progress'])
        ->where(function ($query) use ($startTime, $endTime) {
            $query->whereBetween('start_time', [$startTime, $endTime])
                  ->orWhereBetween('end_time', [$startTime, $endTime])
                  ->orWhere(function ($q) use ($startTime, $endTime) {
                      $q->where('start_time', '<=', $startTime)
                        ->where('end_time', '>=', $endTime);
                  });
        })
        ->exists();

    if ($conflictingOrders) {
        return response()->json([
            'success' => false,
            'message' => 'Bu vaqt slotida allaqachon booking mavjud. Iltimos, boshqa vaqtni tanlang.',
        ], 409); // 409 Conflict
    }

    // Order yaratish
    $order = Order::create([
        'barber_id' => $barberId,
        'client_id' => auth()->id(),
        'service_id' => $serviceIds[0], // Birinchi servis (backward compatibility)
        'start_time' => $startTime,
        'end_time' => $endTime,
        'status' => 'pending',
        'price' => Service::whereIn('id', $serviceIds)->sum('price'),
    ]);

    // Agar bir nechta servis bo'lsa, pivot jadvalga qo'shing
    if (count($serviceIds) > 1) {
        $order->services()->attach($serviceIds);
    }

    return response()->json([
        'success' => true,
        'message' => 'Order created successfully',
        'data' => $order->load(['barber', 'client', 'service', 'shop']),
    ], 201);
}
```

### 2. Database Transaction ishlatish (tavsiya etiladi)

Race conditionlardan himoya qilish uchun database transaction ishlating:

```php
use Illuminate\Support\Facades\DB;

public function store(Request $request)
{
    return DB::transaction(function () use ($request) {
        // ... yuqoridagi kod ...
        
        // Lock barber orders for this time slot
        $conflictingOrders = Order::where('barber_id', $barberId)
            ->whereIn('status', ['pending', 'in_progress'])
            ->where(function ($query) use ($startTime, $endTime) {
                // ... yuqoridagi tekshiruv ...
            })
            ->lockForUpdate() // Database lock
            ->exists();

        if ($conflictingOrders) {
            throw new \Exception('Bu vaqt slotida allaqachon booking mavjud.');
        }

        // Order yaratish
        $order = Order::create([...]);
        
        return response()->json([...]);
    });
}
```

### 3. Qo'shimcha: Optimistic Locking (ixtiyoriy)

Agar siz optimistic locking ishlatmoqchi bo'lsangiz, `orders` jadvaliga `version` yoki `updated_at` ustunidan foydalaning:

```php
// Order yaratishdan oldin
$latestOrder = Order::where('barber_id', $barberId)
    ->whereIn('status', ['pending', 'in_progress'])
    ->latest('updated_at')
    ->first();

// Order yaratish
$order = Order::create([...]);

// Yaratilgandan keyin tekshirish
$conflict = Order::where('barber_id', $barberId)
    ->whereIn('status', ['pending', 'in_progress'])
    ->where('id', '!=', $order->id)
    ->where(function ($query) use ($startTime, $endTime) {
        // ... overlap tekshiruv ...
    })
    ->exists();

if ($conflict) {
    $order->delete();
    return response()->json([
        'success' => false,
        'message' => 'Bu vaqt slotida allaqachon booking mavjud.',
    ], 409);
}
```

### 4. Validation Rules (Laravel)

Custom validation rule yaratish:

```php
// app/Rules/AvailableTimeSlot.php
namespace App\Rules;

use Illuminate\Contracts\Validation\Rule;
use App\Models\Order;
use Carbon\Carbon;

class AvailableTimeSlot implements Rule
{
    protected $barberId;
    protected $serviceIds;

    public function __construct($barberId, $serviceIds)
    {
        $this->barberId = $barberId;
        $this->serviceIds = $serviceIds;
    }

    public function passes($attribute, $value)
    {
        $startTime = Carbon::parse($value);
        $totalDuration = Service::whereIn('id', $this->serviceIds)->sum('duration_minutes');
        $endTime = $startTime->copy()->addMinutes($totalDuration);

        return !Order::where('barber_id', $this->barberId)
            ->whereIn('status', ['pending', 'in_progress'])
            ->where(function ($query) use ($startTime, $endTime) {
                $query->whereBetween('start_time', [$startTime, $endTime])
                      ->orWhereBetween('end_time', [$startTime, $endTime])
                      ->orWhere(function ($q) use ($startTime, $endTime) {
                          $q->where('start_time', '<=', $startTime)
                            ->where('end_time', '>=', $endTime);
                      });
            })
            ->exists();
    }

    public function message()
    {
        return 'Bu vaqt slotida allaqachon booking mavjud.';
    }
}
```

Keyin controllerda:

```php
$request->validate([
    'start_time' => [
        'required',
        'date',
        'after:now',
        new AvailableTimeSlot($barberId, $serviceIds),
    ],
]);
```

## Xulosa

1. **Database Transaction** - Race conditionlardan himoya qilish uchun
2. **Lock For Update** - Concurrent requestlarni boshqarish uchun
3. **Overlap Tekshiruv** - Vaqt slotlarining kesishishini aniqlash
4. **Status Filter** - Faqat `pending` va `in_progress` orderlarni hisobga olish
5. **Error Response** - 409 Conflict status code bilan javob qaytarish

Bu yondashuvlar orqali bir vaqtga faqat bir booking qilishni ta'minlash mumkin.
