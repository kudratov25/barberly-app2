# Client App - Bo'sh Vaqtlar va Bron Qilish Tizimi

## 📱 Client App Requirements

Client app uchun barber'ning bo'sh vaqtlarini ko'rish va bron qilish funksiyasini qo'shish kerak.

---

## 🔌 API Endpoints

### 1. **Get Available Time Slots** (Bo'sh vaqtlarni olish)

```
GET /api/v1/barbers/{barber_id}/available-slots
```

**Query Parameters:**
- `date` (required) - Sana Y-m-d formatida (masalan: `2025-12-15`)
- `service_ids[]` (optional) - Service ID'lar array'i (vaqt yig'indisi hisoblanadi)
- `duration_minutes` (optional) - Agar service_ids bo'lmasa, umumiy vaqt minutlarda

**Request Examples:**
```
// Service IDs bilan
GET /api/v1/barbers/3/available-slots?date=2025-12-15&service_ids[]=1&service_ids[]=2

// Yoki duration bilan
GET /api/v1/barbers/3/available-slots?date=2025-12-15&duration_minutes=50
```

**Response:**
```json
{
  "success": true,
  "message": "Available time slots retrieved successfully",
  "data": {
    "barber_id": 3,
    "date": "2025-12-15",
    "duration_minutes": 50,
    "available_slots": [
      "09:00",
      "09:15",
      "09:30",
      "11:50",
      "12:05",
      "14:00"
    ]
  }
}
```

---

### 2. **Create Order** (Bron yaratish)

```
POST /api/v1/orders
```

**Request Body:**
```json
{
  "barber_id": 3,
  "service_ids": [1, 2],  // soch olish (20 min) + soqol olish (30 min) = 50 min
  "start_time": "2025-12-15T11:00:00"  // ISO format
}
```

**Response:**
```json
{
  "success": true,
  "message": "Order created successfully",
  "data": {
    "id": 123,
    "barber_id": 3,
    "client_id": 5,
    "service_id": 1,
    "status": "pending",
    "price": 50000,
    "start_time": "2025-12-15T11:00:00",
    "end_time": "2025-12-15T11:50:00",
    "created_at": "2025-12-14T10:00:00.000000Z"
  }
}
```

**Error Response (Conflict):**
```json
{
  "success": false,
  "message": "Selected time slot is not available",
  "errors": {
    "start_time": ["This time slot conflicts with existing orders or break time"]
  }
}
```

---

## 🎯 Client App Implementation Requirements

### 1. **Barber Detail Screen** (Barber ma'lumotlari ekrani)

**Features:**
- Barber ma'lumotlari (ism, telefon, rating)
- Xizmatlar ro'yxati (shop xizmatlari)
- "Bron qilish" tugmasi

**UI Flow:**
1. Client barber'ni tanlaydi
2. Xizmatlarni tanlaydi (bir yoki bir nechta)
3. "Bron qilish" tugmasini bosadi
4. Booking screen'ga o'tadi

---

### 2. **Booking Screen** (Bron qilish ekrani)

**Features:**
- **Sana tanlash** (DatePicker)
- **Xizmatlar ro'yxati** (tanlangan xizmatlar)
- **Umumiy narx** (barcha xizmatlar narxi yig'indisi)
- **Umumiy vaqt** (barcha xizmatlar vaqti yig'indisi)
- **Bo'sh vaqtlar ro'yxati** (selected date uchun)
- **Vaqt tanlash** (available slots'dan)
- **Bron qilish tugmasi**

**UI Components:**

#### Date Selector
```dart
// Calendar widget yoki DatePicker
// Sana tanlanganda available slots yuklanadi
```

#### Service List
```dart
// Tanlangan xizmatlar kartalari
// Har birida: nom, narx, vaqt
// O'chirish tugmasi
```

#### Available Time Slots
```dart
// Grid yoki ListView
// Har bir slot: time (HH:mm)
// Tanlash mumkin bo'lgan slotlar: green
// Tanlangan slot: blue border
// Mavjud bo'lmagan slotlar: disabled (agar kelajakda qo'shilsa)
```

#### Booking Button
```dart
// "Bron qilish" tugmasi
// Disabled agar:
//   - Sana tanlanmagan
//   - Vaqt tanlanmagan
//   - Xizmatlar tanlanmagan
```

---

### 3. **Available Slots Loading Logic**

**Flow:**
1. Client sana tanlaydi
2. Tanlangan xizmatlar ID'lari yig'iladi
3. API'ga request yuboriladi:
   ```dart
   GET /api/v1/barbers/{barber_id}/available-slots
   ?date=2025-12-15
   &service_ids[]=1
   &service_ids[]=2
   ```
4. Available slots ro'yxati ko'rsatiladi
5. Client vaqt tanlaydi

**Edge Cases:**
- Agar bo'sh vaqtlar bo'lmasa → "Bu kunda bo'sh vaqtlar mavjud emas" xabari
- Agar xizmatlar tanlanmagan bo'lsa → default duration (masalan: 30 min)
- Loading state → CircularProgressIndicator
- Error state → Error message + retry button

---

### 4. **Order Creation Logic**

**Flow:**
1. Client barcha ma'lumotlarni to'ldiradi:
   - Sana tanlandi
   - Vaqt tanlandi
   - Xizmatlar tanlandi
2. "Bron qilish" tugmasini bosadi
3. API'ga request yuboriladi:
   ```dart
   POST /api/v1/orders
   {
     "barber_id": 3,
     "service_ids": [1, 2],
     "start_time": "2025-12-15T11:00:00"
   }
   ```
4. Success → Order detail screen'ga o'tadi
5. Error (conflict) → Error message ko'rsatiladi, available slots yangilanadi

**Validation:**
- Sana tanlanganligini tekshirish
- Vaqt tanlanganligini tekshirish
- Xizmatlar tanlanganligini tekshirish
- Vaqt kelajakda ekanligini tekshirish

---

## 📁 File Structure

```
lib/
├── models/
│   ├── available_slots_model.dart      # AvailableSlotsResponse model
│   └── order_model.dart                # OrderModel (already exists)
├── services/
│   ├── available_slots_service.dart   # Get available slots API
│   └── order_service.dart              # Create order API (update)
├── screens/
│   ├── barber/
│   │   └── barber_detail_screen.dart   # Barber ma'lumotlari
│   └── booking/
│       └── booking_screen.dart         # Bron qilish ekrani
└── widgets/
    └── time_slot_picker.dart           # Vaqt tanlash widget
```

---

## 🎨 UI Design Specifications

### Booking Screen Layout

```
┌─────────────────────────────────┐
│  ← Barber Detail                │
├─────────────────────────────────┤
│  📅 Sana tanlang                │
│  [2025-12-15] [▼]               │
├─────────────────────────────────┤
│  📋 Tanlangan xizmatlar         │
│  ┌─────────────────────────┐   │
│  │ ✂️ Soch olish           │   │
│  │ 💰 50,000 so'm | 30 min │   │
│  │ [×]                      │   │
│  └─────────────────────────┘   │
│  ┌─────────────────────────┐   │
│  │ ✂️ Soqol olish          │   │
│  │ 💰 30,000 so'm | 20 min │   │
│  │ [×]                      │   │
│  └─────────────────────────┘   │
│                                 │
│  💵 Umumiy: 80,000 so'm         │
│  ⏱️ Vaqt: 50 daqiqa             │
├─────────────────────────────────┤
│  ⏰ Bo'sh vaqtlar               │
│  ┌─────┐ ┌─────┐ ┌─────┐      │
│  │09:00│ │09:15│ │09:30│      │
│  └─────┘ └─────┘ └─────┘      │
│  ┌─────┐ ┌─────┐ ┌─────┐      │
│  │11:50│ │12:05│ │14:00│      │
│  └─────┘ └─────┘ └─────┘      │
├─────────────────────────────────┤
│  [Bron qilish]                  │
└─────────────────────────────────┘
```

### Time Slot States

- **Available** (green background, green border)
- **Selected** (blue background, blue border, bold)
- **Disabled** (gray background, gray border) - kelajakda qo'shilishi mumkin

---

## 🔧 Technical Implementation

### 1. **Available Slots Service**

```dart
class AvailableSlotsService {
  Future<AvailableSlotsResponse> getAvailableSlots({
    required int barberId,
    required String date,
    List<int>? serviceIds,
    int? durationMinutes,
  }) async {
    // API call implementation
  }
}
```

### 2. **Order Service Update**

```dart
class OrderService {
  Future<OrderModel> createOrder({
    required int barberId,
    required List<int> serviceIds,
    required String startTime, // ISO format
  }) async {
    // API call implementation
  }
}
```

### 3. **Booking Screen State Management**

```dart
class BookingScreenState {
  DateTime? selectedDate;
  List<ServiceModel> selectedServices;
  String? selectedTime;
  AvailableSlotsResponse? availableSlots;
  bool isLoading = false;
  
  // Methods
  void selectDate(DateTime date);
  void selectService(ServiceModel service);
  void removeService(ServiceModel service);
  void selectTime(String time);
  Future<void> loadAvailableSlots();
  Future<void> createBooking();
}
```

---

## ✅ Checklist

### Phase 1: Models & Services
- [ ] AvailableSlotsResponse model
- [ ] AvailableSlotsService
- [ ] OrderService.createOrder() update

### Phase 2: Booking Screen
- [ ] Date picker
- [ ] Service list (selected services)
- [ ] Total price calculation
- [ ] Total duration calculation
- [ ] Available slots loading
- [ ] Time slot picker widget
- [ ] Booking button

### Phase 3: Integration
- [ ] Barber detail screen → Booking screen navigation
- [ ] Service selection flow
- [ ] Order creation flow
- [ ] Success/Error handling

### Phase 4: Polish
- [ ] Loading states
- [ ] Empty states
- [ ] Error messages
- [ ] Animations
- [ ] Validation

---

## 🎯 Key Features

1. **Sana tanlash** - Calendar widget yoki DatePicker
2. **Xizmatlar tanlash** - Bir yoki bir nechta xizmat
3. **Bo'sh vaqtlarni ko'rish** - Selected date va services uchun
4. **Vaqt tanlash** - Available slots'dan
5. **Bron qilish** - Order yaratish
6. **Conflict handling** - Agar vaqt band bo'lsa, xato ko'rsatish

---

## 📝 Notes

1. **Service IDs vs Duration:**
   - Agar service_ids berilsa → backend xizmatlar vaqtini yig'adi
   - Agar duration_minutes berilsa → bu vaqt ishlatiladi
   - Priority: service_ids > duration_minutes

2. **Time Format:**
   - Available slots: `"HH:mm"` formatida (masalan: `"09:00"`)
   - Order start_time: ISO format (masalan: `"2025-12-15T11:00:00"`)

3. **Conflict Prevention:**
   - Backend avtomatik conflict tekshiradi
   - Agar conflict bo'lsa, error qaytaradi
   - Frontend available slots yangilaydi

4. **Real-time Updates:**
   - Order yaratilgandan keyin available slots yangilanadi
   - Yoki polling orqali yangilanadi (optional)

---

Bu prompt yordamida client app uchun to'liq bron qilish tizimini yaratishingiz mumkin! 🚀

