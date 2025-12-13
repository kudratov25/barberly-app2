# Backend API O'zgarishlari - Client va Barber App'lar uchun

## 📋 Backend'da Qilingan O'zgarishlar

### 1. **Register Endpoint'ga `app_type` Parametri Qo'shildi**

#### Endpoint
```
POST /api/v1/register
```

#### Request Body
```json
{
  "name": "John Doe",
  "phone": "+998901234567",
  "email": "user@example.com",
  "password": "secret123",
  "password_confirmation": "secret123",
  "app_type": "barber_side" | "client_side"  // Yangi parametr
}
```

#### Logic
- **`app_type: "barber_side"`** → Backend avtomatik `role = owner` qiladi
- **`app_type: "client_side"`** yoki **yo'q** → Backend `role = client` qiladi

#### Client Side App (Hozirgi)
```dart
// lib/features/auth/services/auth_service.dart
final response = await _apiClient.dio.post(
  ApiEndpoints.register,
  data: {
    'name': name,
    'phone': phone,
    'email': email,
    'password': password,
    'password_confirmation': passwordConfirmation,
    'app_type': 'client_side', // ✅ Qo'shildi
  },
);
```

#### Barber Side App (Yangi)
```dart
// lib/features/auth/services/auth_service.dart
final response = await _apiClient.dio.post(
  ApiEndpoints.register,
  data: {
    'name': name,
    'phone': phone,
    'email': email,
    'password': password,
    'password_confirmation': passwordConfirmation,
    'app_type': 'barber_side', // ✅ Barber app uchun
  },
);
```

---

### 2. **Owner va Barber Ikkalasi Ham Status/Location/Schedule Update Qila Oladi**

#### Endpoints (Ikkalasi ham ishlaydi)
- `PUT /api/v1/barbers/status` - Owner va barber ikkalasi ham
- `PUT /api/v1/barbers/location` - Owner va barber ikkalasi ham
- `PUT /api/v1/barbers/schedule` - Owner va barber ikkalasi ham
- `PATCH /api/v1/barbers/schedule/{schedule}` - Owner va barber ikkalasi ham

#### Backend Logic
```php
// Backend'da permission tekshiruvi
if ($user->isOwner() || $user->canManageBarber()) {
    // Status/location/schedule update qilish mumkin
}
```

#### Client Side App
- Bu funksiyalar client side'da kerak emas (client status update qilmaydi)

#### Barber Side App
- Barber va owner ikkalasi ham o'z statusini, location'ini va schedule'ini update qila oladi

---

### 3. **Order Operatsiyalarida Owner Ham Qila Oladi**

#### Endpoints
- `POST /api/v1/orders/{order}/start` - Owner shop owner'i bo'lsa, shop'dagi barberlar orderlarini boshqarishi mumkin
- `POST /api/v1/orders/{order}/finish` - Owner shop owner'i bo'lsa, shop'dagi barberlar orderlarini boshqarishi mumkin
- `POST /api/v1/orders/{order}/cancel` - Owner shop owner'i bo'lsa, shop'dagi barberlar orderlarini boshqarishi mumkin

#### Backend Logic
```php
// Backend'da permission tekshiruvi
$order = Order::findOrFail($id);
$barber = User::find($order->barber_id);

// Owner shop owner'i bo'lsa va order o'sha shop'ga tegishli bo'lsa
if ($user->isOwner() && $user->shop_id == $barber->shop_id) {
    // Order operatsiyalarini bajarish mumkin
}
```

#### Client Side App
- Client faqat order yaratadi, boshqa operatsiyalar barber side'da

#### Barber Side App
- Barber o'z orderlarini boshqaradi
- Owner shop'dagi barcha barberlar orderlarini boshqaradi

---

### 4. **User Modeliga Yangi Metodlar Qo'shildi**

#### Backend Methods
```php
// User modelida
public function isOwner(): bool
{
    return $this->role === 'owner' || 
           ($this->role === 'barber' && $this->shop_id === $this->id);
}

public function canManageBarber(): bool
{
    return $this->isOwner() || $this->role === 'barber';
}
```

#### Client Side App
- Bu metodlar backend'da, client side'da kerak emas

#### Barber Side App
- Frontend'da owner ekanligini tekshirish:
  ```dart
  // User modelida yoki service'da
  bool isOwner(User user) {
    return user.role == 'owner' || 
           (user.role == 'barber' && user.shopId == user.id);
  }
  ```

---

## 🔄 Client Side App'da Qilingan O'zgarishlar

### ✅ Register Service Yangilandi
- `lib/features/auth/services/auth_service.dart`
- `app_type: "client_side"` parametri qo'shildi

---

## 🔄 Barber Side App'da Qilinishi Kerak

### ✅ Register Service
- `app_type: "barber_side"` parametri yuborilishi kerak
- Bu avtomatik owner role beradi

### ✅ Owner Role Detection
- User modelida `isOwner()` helper funksiyasi
- Conditional UI (owner-only features)

### ✅ Order Management
- Owner shop'dagi barcha barberlar orderlarini ko'ra oladi
- Owner orderlarni start/finish/cancel qila oladi

---

## 📝 Xulosa

1. **Register**: `app_type` parametri qo'shildi
2. **Status/Location/Schedule**: Owner va barber ikkalasi ham update qila oladi
3. **Order Operations**: Owner shop'dagi orderlarni boshqaradi
4. **User Methods**: `isOwner()` va `canManageBarber()` backend'da

Barcha o'zgarishlar backend'da amalga oshirilgan va frontend'lar shunga moslashishi kerak.
