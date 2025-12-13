# Barber Side Mobile App - To'liq Prompt va Struktura

## 📱 Barber Side App - Flutter Mobile Application

Barber side uchun to'liq funksional Flutter mobile app yaratish kerak. Bu app barberlar uchun ishlaydi va ular o'z orderlarini, jadvalini, xizmatlarini va statistikalarni boshqarishlari mumkin.

---

## 🎯 Asosiy Features (Funksiyalar)

### 1. **Authentication (Autentifikatsiya)**
- Login (phone + password)
- Register (barber sifatida):
  - **Backend o'zgarishi**: Register endpoint'ga `app_type: "barber_side"` parametri yuboriladi
  - Bu parametr yuborilganda, backend avtomatik `role = owner` qiladi
  - Agar `app_type` yo'q yoki `"client_side"` bo'lsa, `role = client` bo'ladi
- Logout
- Token-based authentication (Laravel Sanctum)

### 2. **Dashboard (Bosh sahifa)**
- Bugungi orderlar ro'yxati (pending, in_progress)
- Eng yaqin order (headerda)
- Bugungi statistika (orderlar soni, daromad)
- Status toggle (online/offline/busy/walk_in)
- Tezkor harakatlar (yangi order, jadval, xizmatlar)

### 3. **Orders Management (Orderlar boshqaruvi)**
- Barcha orderlar ro'yxati (pending, in_progress, completed, cancelled)
- Order detail (mijoz ma'lumotlari, xizmatlar, vaqt, narx)
- **Order qabul qilish (accept/start)**:
  - Order qabul qilinganda:
    - Order statusi `pending`dan `in_progress`ga o'zgaradi
    - **Barber statusi avtomatik `busy`ga o'zgaradi** (backend tomonida)
    - **Clientga avtomatik chat xabari yuboriladi**: "Bron qabul qilindi" yoki "Booking accepted"
- Orderni boshlash (start) - agar accept bo'lmasa
- Orderni tugatish (finish):
  - Order statusi `completed`ga o'zgaradi
  - Barber statusi `online`ga qaytadi (yoki oldingi statusiga)
- Orderni bekor qilish (cancel)
- Filterlar (status, sana bo'yicha)
- Search (mijoz ismi, telefon bo'yicha)

### 4. **Schedule Management (Jadval boshqaruvi)**
- Haftalik jadval ko'rinishi (7 kun)
- Har bir kun uchun ish vaqtlari (start_time, end_time)
- Tanaffus vaqtlari (break_start, break_end)
- Jadvalni tahrirlash
- Ishlash kunlarini tanlash
- Bo'sh vaqt slotlarini ko'rish

### 5. **Services Management (Xizmatlar boshqaruvi)**
- Xizmatlar ro'yxati (shop xizmatlari)
- **Xizmat qo'shish** (faqat shop owner bo'lsa)
  - Name (required)
  - Price (required)
  - Duration minutes (required)
  - Description (optional)
  - Image upload (optional)
- Xizmatni tahrirlash (faqat shop owner bo'lsa)
- Xizmatni o'chirish yoki deaktivatsiya qilish (faqat shop owner bo'lsa)
- Narx va davomiylikni o'zgartirish (faqat shop owner bo'lsa)
- **Owner Control**: Shop owner barcha xizmatlarni to'liq boshqaradi

### 6. **Walk-in Sessions (Tashrif buyuruvchilar)**
- Faol walk-in sessionlar ro'yxati
- Yangi walk-in session yaratish
- Walk-in sessionni boshlash
- Walk-in sessionni tugatish
- Walk-in sessionlar tarixi

### 7. **Chats (Chatlar)**
- Mijozlar bilan chatlar ro'yxati
- Chat xabarlari (real-time polling)
- Xabar yuborish
- Xabarni tahrirlash
- Xabarni o'chirish
- Reply funksiyasi
- Order bilan bog'liq avtomatik xabarlar

### 8. **Statistics (Statistika)**
- Kunlik statistika (orderlar, daromad)
- Oylik statistika (grafiklar bilan)
- Eng ko'p buyurtma qilgan mijozlar
- Eng ko'p ishlatilgan xizmatlar
- Daromad grafiklari (GitHub style)

### 9. **Profile (Profil)**
- Barber ma'lumotlari (ism, telefon, email)
- Rasm yuklash va o'zgartirish
- Location update (GPS)
- Status o'zgartirish
- Statistika ko'rinishi
- Settings

### 10. **Location Tracking (Joylashuv kuzatish)**
- Real-time location update
- GPS orqali avtomatik location yuborish
- Location history

### 11. **Notifications (Xabarnomalar)**
- Yangi order xabarnomalari
- Order yangilanishlari
- Chat xabarlari
- Badge counter

### 12. **Shop Management (Owner/Admin) - Barbershop Boshqaruvi**
**Faqat shop owner (barber-admin) uchun:**

#### 12.1. **Workers Management (Ishchilar Boshqaruvi)**
- Barcha shop ishchilarini ko'rish (barberlar ro'yxati)
- Yangi ishchi (barber) qo'shish
  - Ism, telefon, email
  - Parol belgilash
  - Role: barber
- Ishchini tahrirlash
- Ishchini o'chirish yoki deaktivatsiya qilish
- Har bir ishchining:
  - **Kunlik statistika**: Bugun qancha soch olgani (orders count)
  - **Orderlar soni**: Umumiy orderlar soni
  - **Joriy status**: online/offline/busy/walk_in
  - **Rating**: Mijozlar bahosi
  - **Daromad**: Kunlik/oylik daromad

#### 12.2. **Shop Control Panel (Shop Boshqaruv Paneli)**
- Shop ma'lumotlarini tahrirlash (nomi, manzil, telefon)
- Shop statusini o'zgartirish (active/inactive)
- Subscription plan ko'rinishi
- Shop statistika:
  - Umumiy orderlar
  - Umumiy daromad
  - Faol ishchilar soni
  - Mijozlar soni

#### 12.3. **Workers Statistics Dashboard (Ishchilar Statistika Dashboard)**
- Barcha ishchilar ro'yxati (card format)
- Har bir ishchi kartasida:
  - **Ism va telefon**
  - **Joriy status** (rangli badge: online=green, offline=gray, busy=orange, walk_in=blue)
  - **Rating** (yulduzcha bilan, masalan: ⭐ 4.5)
  - **Kunlik statistika**:
    - Bugungi orderlar soni (kunlik qancha soch olgani)
    - Bugungi daromad
  - **Haftalik statistika**:
    - Haftalik orderlar soni
    - Haftalik daromad
  - **Oylik statistika**:
    - Oylik orderlar soni
    - Oylik daromad
  - **Umumiy statistika**:
    - Umumiy orderlar soni
    - Umumiy daromad
  - **Xizmatlar**:
    - Qancha soch xizmati ko'rsatgani (services count)
    - Eng ko'p ishlatilgan xizmatlar
- Filterlar:
  - Status bo'yicha (All, Online, Offline, Busy, Walk-in)
  - Sana bo'yicha (Bugun, Bu hafta, Bu oy)
- Search: Ism yoki telefon bo'yicha qidirish
- Detail: Ishchini bosib, batafsil statistika ko'rish
- **Period Selector**: Kunlik / Haftalik / Oylik ko'rinish

#### 12.4. **Worker Detail Screen (Ishchi Batafsil Ekran)**
- Ishchi ma'lumotlari (ism, telefon, email, rasm)
- **Rating**: Umumiy rating (yulduzcha bilan)
- **Period Selector**: Kunlik / Haftalik / Oylik
- **Kunlik statistika**:
  - Bugungi orderlar soni (qancha soch olgani)
  - Bugungi daromad
  - Bugungi ish vaqti
  - Bugungi orderlar ro'yxati
- **Haftalik statistika**:
  - Haftalik orderlar soni
  - Haftalik daromad
  - Haftalik orderlar grafigi (Line chart)
- **Oylik statistika**:
  - Oylik orderlar soni
  - Oylik daromad
  - Oylik orderlar grafigi (Line chart)
  - Oylik daromad grafigi (Bar chart)
- **Xizmatlar statistika**:
  - Qancha soch xizmati ko'rsatgani (total services count)
  - Eng ko'p ishlatilgan xizmatlar ro'yxati
  - Har bir xizmat bo'yicha statistika
- **Orderlar tarixi**: Barcha orderlar ro'yxati (filterlar bilan)
- **Ratinglar**: Mijozlar baholari ro'yxati
- **Jadval**: Ishchining ish jadvali

#### 12.5. **Add Worker Screen (Ishchi Qo'shish Ekran)**
- Form fields:
  - Name (required)
  - Phone (required)
  - Email (required)
  - Password (required)
  - Password Confirmation (required)
  - Role: barber (auto-selected)
- Save button
- Success message va yangi ishchi ro'yxatga qo'shiladi

---

## 📁 Project Structure (Loyiha Strukturasi)

```
lib/
├── api/
│   ├── client.dart              # Dio client with interceptors
│   └── endpoints.dart           # API endpoint constants
│
├── common/
│   ├── providers/
│   │   └── providers.dart       # Riverpod providers (services, etc.)
│   ├── routes/
│   │   └── app_router.dart      # GoRouter configuration
│   ├── theme/
│   │   └── app_theme.dart       # App theme (colors, text styles)
│   ├── utils/
│   │   └── storage.dart         # SharedPreferences wrapper
│   └── widgets/
│       └── bottom_nav_bar.dart  # Reusable bottom navigation
│
├── features/
│   ├── auth/
│   │   ├── models/
│   │   │   ├── auth_response.dart
│   │   │   └── user.dart
│   │   ├── screens/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   └── services/
│   │       └── auth_service.dart
│   │
│   ├── dashboard/
│   │   ├── screens/
│   │   │   └── dashboard_screen.dart      # Main dashboard
│   │   └── widgets/
│   │       ├── today_orders_card.dart
│   │       ├── stats_card.dart
│   │       └── quick_actions.dart
│   │
│   ├── orders/
│   │   ├── models/
│   │   │   └── order.dart
│   │   ├── screens/
│   │   │   ├── orders_list_screen.dart     # All orders
│   │   │   ├── order_detail_screen.dart    # Order details
│   │   │   └── order_actions_screen.dart    # Accept/Start/Finish
│   │   └── services/
│   │       └── order_service.dart
│   │
│   ├── schedule/
│   │   ├── models/
│   │   │   └── schedule.dart
│   │   ├── screens/
│   │   │   └── schedule_screen.dart        # Weekly schedule editor
│   │   └── services/
│   │       └── schedule_service.dart
│   │
│   ├── services/
│   │   ├── models/
│   │   │   └── service.dart
│   │   ├── screens/
│   │   │   ├── services_list_screen.dart
│   │   │   ├── service_form_screen.dart    # Add/Edit service
│   │   │   └── service_detail_screen.dart
│   │   └── services/
│   │       └── service_service.dart
│   │
│   ├── walkin/
│   │   ├── models/
│   │   │   └── walkin.dart
│   │   ├── screens/
│   │   │   ├── walkin_list_screen.dart
│   │   │   └── walkin_session_screen.dart
│   │   └── services/
│   │       └── walkin_service.dart
│   │
│   ├── chats/
│   │   ├── models/
│   │   │   ├── chat.dart
│   │   │   └── chat_message.dart
│   │   ├── screens/
│   │   │   ├── chat_list_screen.dart
│   │   │   └── chat_messages_screen.dart
│   │   └── services/
│   │       └── chat_service.dart
│   │
│   ├── stats/
│   │   ├── models/
│   │   │   └── stats.dart
│   │   ├── screens/
│   │   │   └── stats_screen.dart           # GitHub-style charts
│   │   └── services/
│   │       └── stats_service.dart
│   │
│   ├── profile/
│   │   ├── screens/
│   │   │   └── profile_screen.dart
│   │   └── widgets/
│   │       └── avatar_picker.dart
│   │
│   ├── shop_management/          # Owner/Admin funksiyalar
│   │   ├── models/
│   │   │   └── worker_stats.dart
│   │   ├── screens/
│   │   │   ├── workers_list_screen.dart      # Barcha ishchilar
│   │   │   ├── worker_detail_screen.dart     # Ishchi batafsil
│   │   │   ├── add_worker_screen.dart        # Yangi ishchi qo'shish
│   │   │   ├── edit_worker_screen.dart        # Ishchini tahrirlash
│   │   │   └── shop_control_panel_screen.dart # Shop boshqaruvi
│   │   └── services/
│   │       └── shop_management_service.dart
│   │
│   └── location/
│       └── services/
│           └── location_service.dart       # GPS tracking
│
└── screens/
    ├── splash_screen.dart
    └── home_screen.dart                    # Main entry point
```

---

## 🎨 Design Requirements (Dizayn Talablari)

### Color Scheme (Rang sxemasi)
- **Primary**: `#0A84FF` (Blue)
- **Secondary**: `#4DA8FF` (Light Blue)
- **Success**: `#10B981` (Green)
- **Warning**: `#F59E0B` (Orange)
- **Error**: `#EF4444` (Red)
- **Background**: `#FAFAFA` (Light Gray)
- **Text Primary**: `#111827` (Dark Gray)
- **Text Secondary**: `#6B7280` (Medium Gray)

### UI Components (UI Komponentlar)
- **Cards**: Rounded corners (20px), shadow
- **Buttons**: Gradient backgrounds, rounded (999px for pills)
- **Input Fields**: Rounded borders, filled background
- **AppBar**: White background, gradient for detail screens
- **Bottom Navigation**: 5 tabs (Dashboard, Orders, Schedule, Chats, Profile)

---

## 🔌 API Endpoints (Kerakli API'lar)

### Authentication
- `POST /api/v1/login` - Login
- `POST /api/v1/register` - Register
  - **Backend o'zgarishi**: `app_type` parametri qo'shildi
  - `app_type: "barber_side"` → `role = owner` (barber app uchun)
  - `app_type: "client_side"` yoki yo'q → `role = client` (client app uchun)
  - Barber app'da register qilganda `app_type: "barber_side"` yuborilishi kerak
- `POST /api/v1/logout` - Logout
- `GET /api/v1/me` - Get current user

### Orders
- `GET /api/v1/orders?role=barber` - List orders (barber's orders)
- `GET /api/v1/orders?role=barber&shop_id=:id` - List shop orders (owner uchun)
- `GET /api/v1/orders/:id` - Get order details
- `POST /api/v1/orders/:id/start` - Start order
  - **Backend Logic**: 
    - Order statusi `in_progress`ga o'zgaradi
    - Barber statusi avtomatik `busy`ga o'zgaradi
    - Clientga chat xabari yuboriladi: "Bron qabul qilindi"
- `POST /api/v1/orders/:id/finish` - Finish order
  - **Backend Logic**:
    - Order statusi `completed`ga o'zgaradi
    - Barber statusi `online`ga qaytadi (yoki oldingi statusiga)
- `POST /api/v1/orders/:id/cancel` - Cancel order
- `GET /api/v1/orders?status=pending&role=barber` - Filter orders

### Schedule
- `GET /api/v1/barbers/schedule` - Get barber schedule
- `PUT /api/v1/barbers/schedule` - Update schedule

### Services
- `GET /api/v1/services?shop_id=:id` - List shop services
- `POST /api/v1/services` - Create service (shop owner only)
- `PUT /api/v1/services/:id` - Update service
- `DELETE /api/v1/services/:id` - Delete service

### Walk-in
- `GET /api/v1/walkin` - List walk-in sessions
- `POST /api/v1/walkin` - Create walk-in session
- `POST /api/v1/walkin/:id/start` - Start walk-in
- `POST /api/v1/walkin/:id/finish` - Finish walk-in

### Chats
- `GET /api/v1/chats` - List chats
- `GET /api/v1/chats/:id` - Get chat
- `GET /api/v1/chats/:id/messages` - List messages
- `POST /api/v1/chats/:id/messages` - Send message
- `PATCH /api/v1/chats/:id/messages/:messageId` - Update message
- `DELETE /api/v1/chats/:id/messages/:messageId` - Delete message
- `POST /api/v1/chats/:id/read` - Mark as read

### Stats
- `GET /api/v1/stats/me/daily?month=2025-12` - Daily stats
- `GET /api/v1/stats/me/monthly?year=2025` - Monthly stats

### Location
- `PUT /api/v1/users/location` - Update location (lat, lng)

### Status
- `PUT /api/v1/barbers/status` - Update status (online/offline/busy/walk_in)

### Shop Management (Owner/Admin)
- `GET /api/v1/shops/:id` - Get shop details (owner shop)
- `PUT /api/v1/shops/:id` - Update shop (owner only)
- `GET /api/v1/shops/:id/barbers` - List shop barbers (owner only)
- `POST /api/v1/shops/:id/barbers` - Add new barber to shop (owner only)
- `PUT /api/v1/shops/:id/barbers/:barber_id` - Update barber (owner only)
- `DELETE /api/v1/shops/:id/barbers/:barber_id` - Remove barber (owner only)
- `GET /api/v1/shops/:id/barbers/:barber_id/stats?date=2025-12-11` - Get barber daily stats (owner only)
- `GET /api/v1/shops/:id/barbers/:barber_id/stats?period=weekly` - Get barber weekly stats (owner only)
- `GET /api/v1/shops/:id/barbers/:barber_id/stats?period=monthly&month=2025-12` - Get barber monthly stats (owner only)
- `GET /api/v1/shops/:id/stats` - Get shop statistics (owner only)
- **Barber Stats Response**:
  ```json
  {
    "success": true,
    "data": {
      "barber_id": 1,
      "barber_name": "Barber Name",
      "rating_avg": 4.5,
      "rating_count": 120,
      "daily": {
        "date": "2025-12-11",
        "orders_count": 5,
        "services_count": 5,  // Qancha soch xizmati
        "revenue": 250000
      },
      "weekly": {
        "week": "2025-12-08 to 2025-12-14",
        "orders_count": 35,
        "services_count": 35,
        "revenue": 1750000
      },
      "monthly": {
        "month": "2025-12",
        "orders_count": 150,
        "services_count": 150,
        "revenue": 7500000
      },
      "total": {
        "orders_count": 500,
        "services_count": 500,
        "revenue": 25000000
      }
    }
  }
  ```

---

## 📱 Screen Specifications (Ekran Spetsifikatsiyalari)

### 1. **Dashboard Screen**
- **Header**: Barber name, avatar, status toggle (online/offline/busy)
- **Owner Badge**: Agar shop owner bo'lsa, "Owner" badge ko'rsatiladi
- **Today's Orders Card**: Bugungi orderlar ro'yxati (pending, in_progress)
- **Stats Card**: Bugungi statistika (orderlar soni, daromad)
- **Quick Actions**: 
  - New Order
  - Schedule
  - Services
  - Walk-in
  - **Workers** (faqat owner uchun)
  - **Shop Control** (faqat owner uchun)
- **Upcoming Orders**: Eng yaqin 3 ta order
- **Workers Status** (faqat owner uchun): Qisqa ishchilar ro'yxati (status bilan)

### 2. **Orders List Screen**
- **Filter Chips**: All, Pending, In Progress, Completed, Cancelled
- **Search Bar**: Mijoz ismi, telefon bo'yicha qidirish
- **Order Cards**: 
  - Mijoz ismi, telefon
  - Xizmatlar ro'yxati
  - Vaqt (sana, soat)
  - Narx
  - Status badge
  - Action buttons (Accept/Start, Finish, Cancel)
- **Order Accept/Start Logic**:
  - "Accept" yoki "Start" bosilganda:
    - Order statusi `in_progress`ga o'zgaradi
    - Barber statusi avtomatik `busy`ga o'zgaradi (backend)
    - Clientga chat xabari yuboriladi: "Bron qabul qilindi" yoki "Booking accepted"

### 3. **Order Detail Screen**
- **SliverAppBar**: Gradient background, order ID
- **Status Badge**: Rangli status ko'rsatkich
- **Client Info**: Mijoz ma'lumotlari, telefon, chat button
- **Service Info**: Xizmatlar ro'yxati, narx
- **Time Info**: Sana, vaqt
- **Action Buttons**: 
  - **Accept/Start** (pending bo'lsa):
    - Order statusi `in_progress`ga o'zgaradi
    - Barber statusi avtomatik `busy`ga o'zgaradi
    - Clientga chat xabari: "Bron qabul qilindi"
  - **Finish** (in_progress bo'lsa):
    - Order statusi `completed`ga o'zgaradi
    - Barber statusi `online`ga qaytadi (yoki oldingi statusiga)
  - **Cancel** (pending yoki in_progress bo'lsa)

### 4. **Schedule Screen**
- **Week View**: 7 kun ko'rinishi
- **Day Editor**: 
  - Ishlash kunini yoqish/o'chirish
  - Start time picker
  - End time picker
  - Break time picker (optional)
- **Save Button**: Jadvalni saqlash

### 5. **Services List Screen**
- **Add Service Button** (shop owner uchun)
- **Service Cards**: 
  - Xizmat nomi
  - Narx
  - Davomiylik
  - Edit/Delete buttons

### 6. **Service Form Screen**
- **Form Fields**:
  - Name (required)
  - Price (required)
  - Duration (minutes, required)
  - Description (optional)
  - Image upload (optional)
- **Save Button**

### 7. **Walk-in List Screen**
- **Active Sessions**: Faol walk-in sessionlar
- **History**: Tugallangan sessionlar
- **Create Button**: Yangi walk-in yaratish

### 8. **Walk-in Session Screen**
- **Client Info**: Mijoz ma'lumotlari
- **Services**: Xizmatlar ro'yxati
- **Start/Finish Buttons**
- **Timer**: Session davomiyligi

### 9. **Chat List Screen**
- **Chat Cards**: 
  - Mijoz ismi, avatar
  - Oxirgi xabar
  - Vaqt
  - Unread badge

### 10. **Chat Messages Screen**
- **Message Bubbles**: 
  - Sent messages (o'ng tomonda, ko'k)
  - Received messages (chap tomonda, oq)
- **Input Field**: Xabar yozish
- **Actions**: Reply, Edit, Delete
- **Real-time Updates**: Polling (2-3 soniya)

### 11. **Stats Screen**
- **Period Selector**: Daily/Monthly toggle
- **Summary Cards**: Total Orders, Total Revenue
- **Charts**: 
  - Daily: Line chart
  - Monthly: Bar chart
- **Data Table**: Top 10 ta ma'lumot

### 12. **Profile Screen**
- **Avatar**: Rasm yuklash
- **User Info**: Ism, telefon, email
- **Role Badge**: Barber yoki Owner ko'rsatiladi
- **Stats**: Orderlar, daromad
- **Settings**: 
  - Location update
  - Status change
  - Logout
- **Owner Section** (faqat owner uchun):
  - Shop Management
  - Workers Management
  - Shop Statistics

### 13. **Workers List Screen (Owner)**
- **Header**: "Shop Workers" title, "Add Worker" button
- **Filter Chips**: All, Online, Offline, Busy, Walk-in
- **Search Bar**: Ism yoki telefon bo'yicha qidirish
- **Worker Cards**: 
  - Avatar (yoki initial)
  - Ism va telefon
  - **Status Badge** (rangli: online=green, offline=gray, busy=orange, walk_in=blue)
  - **Bugungi statistika**:
    - Bugungi orderlar: "5 orders today"
    - Bugungi daromad: "250,000 UZS"
  - **Umumiy statistika**:
    - Umumiy orderlar: "120 orders"
    - Rating: ⭐ 4.5
  - **Tap to view details** → Worker Detail Screen

### 14. **Worker Detail Screen (Owner)**
- **SliverAppBar**: Gradient background, worker name
- **Worker Info Card**:
  - Avatar, ism, telefon, email
  - **Joriy status** (rangli badge)
  - Edit button (owner uchun)
- **Today's Statistics Card**:
  - Bugungi orderlar soni
  - Bugungi daromad
  - Bugungi ish vaqti
- **Monthly Statistics Card**:
  - Oylik orderlar grafigi (Line chart)
  - Oylik daromad grafigi (Bar chart)
- **Recent Orders**: Oxirgi 10 ta order
- **Rating**: Mijozlar baholari ro'yxati

### 15. **Add Worker Screen (Owner)**
- **Form Fields**:
  - Name (required, TextField)
  - Phone (required, TextField with validation)
  - Email (required, TextField with email validation)
  - Password (required, TextField with obscureText)
  - Password Confirmation (required, TextField)
- **Save Button**: Yangi ishchini yaratadi
- **Success**: SnackBar va Workers List'ga qaytadi

### 16. **Shop Control Panel Screen (Owner)**
- **Shop Info Card**:
  - Shop name, address, phone
  - Edit button
- **Subscription Card**:
  - Plan name, price
  - Status (active/inactive)
- **Shop Statistics**:
  - Total orders
  - Total revenue
  - Active workers count
  - Total clients
- **Quick Actions**:
  - Edit Shop Info
  - Manage Services
  - Manage Workers
  - View Shop Stats

---

## 🛠️ Technical Requirements (Texnik Talablar)

### Packages (Paketlar)
```yaml
dependencies:
  flutter_riverpod: ^2.6.1
  dio: ^5.7.0
  go_router: ^14.6.2
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  shared_preferences: ^2.3.3
  intl: ^0.19.0
  image_picker: ^1.1.2
  fl_chart: ^0.69.0
  geolocator: ^10.1.0  # GPS tracking
  url_launcher: ^6.3.0
```

### State Management
- **Riverpod** - Barcha state management uchun
- **ConsumerWidget** / **ConsumerStatefulWidget** - UI widgets
- **FutureProvider** / **StateProvider** - Data providers

### Navigation
- **GoRouter** - Declarative routing
- Routes:
  - `/splash` - Splash screen
  - `/login` - Login
  - `/register` - Register
  - `/dashboard` - Dashboard (home)
  - `/orders` - Orders list
  - `/orders/:id` - Order detail
  - `/schedule` - Schedule management
  - `/services` - Services list
  - `/services/new` - Create service
  - `/services/:id/edit` - Edit service
  - `/walkin` - Walk-in list
  - `/walkin/:id` - Walk-in session
  - `/chats` - Chat list
  - `/chats/:id` - Chat messages
  - `/stats` - Statistics
  - `/profile` - Profile
  - `/workers` - Workers list (owner only)
  - `/workers/:id` - Worker detail (owner only)
  - `/workers/new` - Add worker (owner only)
  - `/workers/:id/edit` - Edit worker (owner only)
  - `/shop/control` - Shop control panel (owner only)

### Data Models
- **Freezed** - Immutable models
- **json_serializable** - JSON serialization
- Barcha model'lar client side bilan bir xil struktura

### Error Handling
- DioException handling
- User-friendly error messages
- SnackBar notifications
- Retry mechanisms

### Real-time Updates
- **Polling** - Chat messages (2-3 soniya)
- **Timer.periodic** - Order updates
- **FutureBuilder** - Data fetching

---

## 📋 Implementation Checklist (Amalga Oshirish Ro'yxati)

### Phase 1: Setup (Birinchi bosqich)
- [ ] Flutter project yaratish
- [ ] Dependencies qo'shish
- [ ] Project structure yaratish
- [ ] API client setup
- [ ] Theme configuration
- [ ] Router setup

### Phase 2: Authentication (Ikkinchi bosqich)
- [ ] Login screen
- [ ] Register screen
  - **Muhim**: Register endpoint'ga `app_type: "barber_side"` parametri yuborilishi kerak
  - Bu backend'da avtomatik `role = owner` qiladi
- [ ] Auth service
- [ ] Token storage
- [ ] Auth guards

### Phase 3: Dashboard (Uchinchi bosqich)
- [ ] Dashboard screen
- [ ] Today's orders widget
- [ ] Stats widget
- [ ] Quick actions
- [ ] Status toggle

### Phase 4: Orders (To'rtinchi bosqich)
- [ ] Orders list screen
- [ ] Order detail screen
- [ ] Order actions (accept, start, finish, cancel)
- [ ] Filters and search
- [ ] Real-time updates

### Phase 5: Schedule (Beshinchi bosqich)
- [ ] Schedule screen
- [ ] Week view
- [ ] Day editor
- [ ] Schedule service
- [ ] Save functionality

### Phase 6: Services (Oltinchi bosqich)
- [ ] Services list screen
- [ ] Service form screen
- [ ] Service CRUD operations
- [ ] Image upload

### Phase 7: Walk-in (Yettinchi bosqich)
- [ ] Walk-in list screen
- [ ] Walk-in session screen
- [ ] Create walk-in
- [ ] Start/Finish walk-in

### Phase 8: Chats (Sakkizinchi bosqich)
- [ ] Chat list screen
- [ ] Chat messages screen
- [ ] Send message
- [ ] Edit/Delete message
- [ ] Reply functionality
- [ ] Real-time polling

### Phase 9: Stats (To'qqizinchi bosqich)
- [ ] Stats screen
- [ ] Daily/Monthly toggle
- [ ] Charts (fl_chart)
- [ ] Data tables

### Phase 10: Profile (O'ninchi bosqich)
- [ ] Profile screen
- [ ] Avatar upload
- [ ] Location update
- [ ] Settings

### Phase 11: Location (O'n birinchi bosqich)
- [ ] GPS tracking
- [ ] Location service
- [ ] Auto location update

### Phase 12: Shop Management (Owner) (O'n ikkinchi bosqich)
- [ ] Workers list screen
- [ ] Worker detail screen
- [ ] Add worker screen
- [ ] Edit worker screen
- [ ] Shop control panel screen
- [ ] Worker statistics API integration
- [ ] Owner role detection
- [ ] Conditional UI (owner-only features)

### Phase 13: Polish (O'n uchinchi bosqich)
- [ ] Error handling
- [ ] Loading states
- [ ] Empty states
- [ ] Animations
- [ ] Testing

---

## 🎯 Key Differences from Client App (Client Appdan Farqlari)

1. **Dashboard Focus**: Barber app'da dashboard asosiy sahifa (orders, stats)
2. **Order Management**: Barber orderlarni qabul qiladi, boshlaydi, tugatadi
3. **Schedule Management**: Barber o'z jadvalini boshqaradi
4. **Services Management**: Shop owner bo'lsa, xizmatlarni boshqaradi
5. **Status Management**: Online/offline/busy/walk_in statuslarni o'zgartiradi
6. **Location Tracking**: Real-time GPS tracking
7. **Walk-in Sessions**: Tashrif buyuruvchilar bilan ishlash
8. **Owner/Admin Features**: 
   - Shop owner (barber-admin) barcha shop funksiyalarini boshqaradi
   - Yangi ishchi (barber) qo'shish
   - Barcha ishchilarni ko'rish va boshqarish
   - Har bir ishchining kunlik statistikalari (qancha soch olgani, orderlar soni, status)
   - Shop to'liq kontroli

---

## 📝 Notes (Eslatmalar)

1. **API Compatibility**: Barcha API'lar `collection1.json` faylida mavjud bo'lishi kerak
2. **Design Consistency**: Client app bilan bir xil dizayn stilidan foydalanish
3. **Code Reusability**: Common widgets va utilities'ni qayta ishlatish
4. **Error Handling**: Barcha API call'larda error handling bo'lishi kerak
5. **Loading States**: Barcha async operatsiyalarda loading indicator
6. **Empty States**: Ma'lumot bo'lmasa, empty state ko'rsatish
7. **Real-time Updates**: Orderlar va chatlar real-time yangilanadi
8. **Owner Role Detection**: 
   - User modelida `role` yoki `shop_id` va `owner_id` tekshiriladi
   - Agar `user.role == 'barber'` va `user.shop_id == user.id` (yoki `user.owner_id == user.id`) bo'lsa, owner hisoblanadi
   - Owner funksiyalari faqat owner uchun ko'rsatiladi
9. **Worker Statistics**:
   - Har bir barberning kunlik/haftalik/oylik statistikalari API orqali olinadi
   - Bugungi orderlar soni, daromad, status real-time yangilanadi
   - **Qancha soch xizmati ko'rsatgani** (`services_count`) ko'rsatiladi
   - **Rating** ko'rsatiladi
   - Owner barcha ishchilarning statistikalarini ko'radi
10. **Shop Control**:
    - Owner o'z shop'ini to'liq boshqaradi
    - Barcha xizmatlar, ishchilar, statistika owner kontrolida
11. **Order Acceptance Logic**:
    - Order start qilinganda barber statusi avtomatik `busy`ga o'zgaradi (backend)
    - Clientga "Bron qabul qilindi" chat xabari yuboriladi (backend)
    - Order finish qilinganda barber statusi `online`ga qaytadi (agar boshqa active orderlar bo'lmasa)
12. **Barber Statistics for Owner**:
    - Owner barcha barberlarning rating'ini ko'radi
    - Kunlik/haftalik/oylik daromadlarni ko'radi
    - Qancha soch xizmati ko'rsatganini ko'radi
    - Barcha statistika grafiklar bilan ko'rsatiladi

---

## 🚀 Getting Started (Boshlash)

1. **Yangi Flutter project yaratish**:
```bash
flutter create barberly_barber_app
cd barberly_barber_app
```

2. **Dependencies qo'shish** (`pubspec.yaml`):
```yaml
dependencies:
  flutter_riverpod: ^2.6.1
  dio: ^5.7.0
  go_router: ^14.6.2
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  shared_preferences: ^2.3.3
  intl: ^0.19.0
  image_picker: ^1.1.2
  fl_chart: ^0.69.0
  geolocator: ^10.1.0
  url_launcher: ^6.3.0
```

3. **Project structure yaratish** (yuqoridagi strukturaga ko'ra)

4. **API base URL ni sozlash** (`lib/api/endpoints.dart`)

5. **Build runner ishga tushirish**:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

6. **Appni ishga tushirish**:
```bash
flutter run
```

---

Bu prompt client side app bilan bir xil struktura va dizayn stilida barber side app yaratish uchun to'liq qo'llanma. Barcha feature'lar, screen'lar, API endpoint'lar va texnik talablar batafsil yozilgan.
