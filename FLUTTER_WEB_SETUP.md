# Flutter Web'da Ishga Tushirish Qo'llanmasi

## 🌐 Web'da Flutter Appni Ishga Tushirish

### 1. **Chrome'da Ishga Tushirish** (Tavsiya etiladi)

```bash
flutter run -d chrome
```

Yoki:

```bash
flutter run -d web-server
```

### 2. **Barber Appni Web'da Ishga Tushirish**

Barber app uchun ham bir xil:

```bash
cd barberly_barber_app  # Barber app papkasi
flutter run -d chrome
```

### 3. **Web Server Portini O'zgartirish**

Agar port o'zgartirish kerak bo'lsa:

```bash
flutter run -d chrome --web-port=8080
```

### 4. **Release Mode'da Build Qilish**

Production uchun:

```bash
flutter build web
```

Keyin `build/web` papkasidagi fayllarni serverga yuklash.

### 5. **Web'da Debug Qilish**

Chrome DevTools bilan:

```bash
flutter run -d chrome --web-renderer html
```

Yoki CanvasKit renderer (tezroq):

```bash
flutter run -d chrome --web-renderer canvaskit
```

---

## 📱 Ikki Appni Bir Vaqtda Ishga Tushirish

### Variant 1: Ikki Terminal

**Terminal 1** (Client App):
```bash
cd /Users/macstore.uz/Desktop/barberly-2v/barberly-app2
flutter run -d chrome --web-port=8080
```

**Terminal 2** (Barber App):
```bash
cd /Users/macstore.uz/Desktop/barberly-2v/barberly-barber-app
flutter run -d chrome --web-port=8081
```

### Variant 2: Background'da Ishga Tushirish

**Terminal 1** (Client App):
```bash
cd /Users/macstore.uz/Desktop/barberly-2v/barberly-app2
flutter run -d chrome --web-port=8080 &
```

**Terminal 2** (Barber App):
```bash
cd /Users/macstore.uz/Desktop/barberly-2v/barberly-barber-app
flutter run -d chrome --web-port=8081
```

---

## 🔧 Web'da Muammolar va Yechimlar

### 1. **Image Picker Web'da Ishlamaydi**

Web'da `image_picker` cheklangan. Yechim:

```dart
import 'dart:html' as html;

Future<void> _pickImage() async {
  if (kIsWeb) {
    // Web uchun HTML file input
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();
    
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files[0];
        final reader = html.FileReader();
        reader.onLoadEnd.listen((e) {
          // Rasmni ko'rsatish
        });
        reader.readAsDataUrl(file);
      }
    });
  } else {
    // Mobile uchun image_picker
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // ...
  }
}
```

### 2. **Geolocator Web'da**

Web'da GPS tracking cheklangan. Yechim:

```dart
import 'package:geolocator/geolocator.dart';

Future<void> updateLocation() async {
  if (kIsWeb) {
    // Web uchun browser geolocation API
    // Yoki manual location input
  } else {
    // Mobile uchun geolocator
    Position position = await Geolocator.getCurrentPosition();
    // ...
  }
}
```

### 3. **SharedPreferences Web'da**

Web'da `shared_preferences` `localStorage` orqali ishlaydi - muammo yo'q.

### 4. **Hot Reload Web'da**

Web'da hot reload ishlaydi, lekin ba'zida to'liq reload kerak bo'ladi:
- `R` - Hot Restart
- `r` - Hot Reload

---

## 🚀 Quick Start Commands

### Client App (Hozirgi):
```bash
cd /Users/macstore.uz/Desktop/barberly-2v/barberly-app2
flutter run -d chrome
```

### Barber App (Yangi):
```bash
cd /Users/macstore.uz/Desktop/barberly-2v/barberly-barber-app
flutter run -d chrome --web-port=8081
```

---

## 📝 Notes

1. **Web Support**: Flutter web'da to'liq ishlaydi, lekin ba'zi paketlar cheklangan (image_picker, geolocator)
2. **Performance**: Web'da performance mobile'dan biroz pastroq bo'lishi mumkin
3. **Browser**: Chrome, Firefox, Safari, Edge - barchasida ishlaydi
4. **Port**: Default port `8080`, o'zgartirish mumkin

---

## 🎯 Barber Appni Web'da Test Qilish

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
  # ... boshqalar
```

3. **Web'da ishga tushirish**:
```bash
flutter run -d chrome
```

4. **Ikki appni bir vaqtda**:
   - Client app: `http://localhost:8080`
   - Barber app: `http://localhost:8081`

---

Bu qo'llanma yordamida ikkala appni ham web'da ishga tushirishingiz mumkin! 🚀
