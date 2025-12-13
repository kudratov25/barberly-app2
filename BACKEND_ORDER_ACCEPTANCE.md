# Backend: Order Qabul Qilish va Status O'zgarishi

## Muammo
Barber orderni qabul qilganida (start qilganida):
1. Barber statusi avtomatik `busy`ga o'zgarishi kerak
2. Clientga "Bron qabul qilindi" xabari chat orqali yuborilishi kerak

## Yechim

### 1. Order Start Endpoint (POST /api/v1/orders/:id/start)

`OrderController@start()` metodida quyidagi o'zgarishlar:

```php
public function start($id)
{
    return DB::transaction(function () use ($id) {
        $order = Order::findOrFail($id);
        
        // Faqat pending orderlarni start qilish mumkin
        if ($order->status !== 'pending') {
            return response()->json([
                'success' => false,
                'message' => 'Order cannot be started. It must be in pending status.',
            ], 400);
        }
        
        // Order statusini o'zgartirish
        $order->status = 'in_progress';
        $order->started_at = now();
        $order->save();
        
        // Barber statusini avtomatik 'busy'ga o'zgartirish
        $barber = User::find($order->barber_id);
        if ($barber && $barber->role === 'barber') {
            $barber->schedule_status = 'busy';
            $barber->save();
        }
        
        // Clientga chat xabari yuborish
        try {
            $chat = Chat::firstOrCreate([
                'barber_id' => $order->barber_id,
                'client_id' => $order->client_id,
            ]);
            
            $message = ChatMessage::create([
                'chat_id' => $chat->id,
                'sender_id' => $order->barber_id,
                'message' => 'Bron qabul qilindi',
                'order_id' => $order->id,
                'is_read' => false,
            ]);
            
            // Chat'ni yangilash (latest_message)
            $chat->update([
                'latest_message_id' => $message->id,
                'updated_at' => now(),
            ]);
        } catch (\Exception $e) {
            // Chat xatosi order yaratishni to'xtatmaydi
            \Log::error('Failed to send chat message: ' . $e->getMessage());
        }
        
        return response()->json([
            'success' => true,
            'message' => 'Order started successfully',
            'data' => $order->load(['barber', 'client', 'service', 'shop']),
        ], 200);
    });
}
```

### 2. Order Finish Endpoint (POST /api/v1/orders/:id/finish)

Order tugatilganda barber statusini qaytarish:

```php
public function finish($id)
{
    return DB::transaction(function () use ($id) {
        $order = Order::findOrFail($id);
        
        if ($order->status !== 'in_progress') {
            return response()->json([
                'success' => false,
                'message' => 'Order cannot be finished. It must be in progress.',
            ], 400);
        }
        
        $order->status = 'completed';
        $order->finished_at = now();
        $order->save();
        
        // Barber statusini 'online'ga qaytarish (yoki oldingi statusiga)
        $barber = User::find($order->barber_id);
        if ($barber && $barber->role === 'barber') {
            // Agar boshqa in_progress orderlar bo'lmasa, online qilish
            $hasActiveOrders = Order::where('barber_id', $barber->id)
                ->where('status', 'in_progress')
                ->exists();
            
            if (!$hasActiveOrders) {
                $barber->schedule_status = 'online';
                $barber->save();
            }
        }
        
        return response()->json([
            'success' => true,
            'message' => 'Order finished successfully',
            'data' => $order->load(['barber', 'client', 'service', 'shop']),
        ], 200);
    });
}
```

### 3. Order Cancel Endpoint (POST /api/v1/orders/:id/cancel)

Order bekor qilinganda ham barber statusini tekshirish:

```php
public function cancel($id)
{
    return DB::transaction(function () use ($id) {
        $order = Order::findOrFail($id);
        
        if (!in_array($order->status, ['pending', 'in_progress'])) {
            return response()->json([
                'success' => false,
                'message' => 'Order cannot be cancelled.',
            ], 400);
        }
        
        $barberId = $order->barber_id;
        
        $order->status = 'cancelled';
        $order->cancelled_at = now();
        $order->save();
        
        // Agar in_progress bo'lsa, barber statusini tekshirish
        if ($order->getOriginal('status') === 'in_progress') {
            $barber = User::find($barberId);
            if ($barber && $barber->role === 'barber') {
                $hasActiveOrders = Order::where('barber_id', $barberId)
                    ->where('status', 'in_progress')
                    ->exists();
                
                if (!$hasActiveOrders) {
                    $barber->schedule_status = 'online';
                    $barber->save();
                }
            }
        }
        
        return response()->json([
            'success' => true,
            'message' => 'Order cancelled successfully',
            'data' => $order->load(['barber', 'client', 'service', 'shop']),
        ], 200);
    });
}
```

## Xulosa

1. **Order Start**: Barber statusi avtomatik `busy`ga o'zgaradi
2. **Chat Message**: Clientga "Bron qabul qilindi" xabari yuboriladi
3. **Order Finish**: Agar boshqa active orderlar bo'lmasa, barber statusi `online`ga qaytadi
4. **Transaction**: Barcha operatsiyalar database transaction ichida

Bu yondashuv orqali order qabul qilinganda barber statusi avtomatik yangilanadi va clientga xabar yuboriladi.
