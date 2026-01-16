# Release Signing Setup (Keystore Sozlash)

Google Play Console'ga release build yuklash uchun keystore yaratish va sozlash kerak.

## 1. Keystore yaratish

Terminalda quyidagi buyruqni bajaring:

```bash
cd android
keytool -genkey -v -keystore app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Yoki Windows PowerShell'da:

```powershell
cd android
keytool -genkey -v -keystore app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**Eslatma:** 
- `upload-keystore.jks` - keystore fayl nomi (o'zgartirishingiz mumkin)
- `upload` - key alias nomi (o'zgartirishingiz mumkin)
- `10000` - keystore amal qilish muddati (kunlarda, taxminan 27 yil)

Sizdan quyidagi ma'lumotlar so'raladi:
- **Keystore password:** Keystore paroli (eslab qoling!)
- **Key password:** Key paroli (odatda keystore paroli bilan bir xil)
- **Ismingiz:** To'liq ismingiz
- **Tashkilot birligi:** Kompaniya nomi
- **Tashkilot:** Kompaniya nomi
- **Shahar:** Shahar nomi
- **Shtat:** Shtat nomi
- **Ikki harfli mamlakat kodi:** Masalan, UZ, US, RU

## 2. key.properties fayl yaratish

`android/key.properties.example` faylini nusxalab `android/key.properties` nomiga o'zgartiring va quyidagilarni to'ldiring:

```properties
storePassword=your_keystore_password_here
keyPassword=your_key_password_here
keyAlias=upload
storeFile=../app/upload-keystore.jks
```

**Muhim:** 
- `key.properties` fayl `.gitignore`'da, shuning uchun GitHub'ga yuklanmaydi
- Parollarni xavfsiz saqlang!
- Keystore faylini yedeklang va xavfsiz joyda saqlang

## 3. Build yaratish

Endi release build yaratishingiz mumkin:

```bash
flutter build appbundle --release
```

Yoki APK uchun:

```bash
flutter build apk --release
```

## 4. Keystore xavfsizligi

- **Keystore fayl va parollarni yedeklang!** Agar yo'qotsangiz, app'ni yangilab bo'lmaydi
- Keystore faylni GitHub yoki boshqa public joyga yuklamang
- Parollarni password manager'da saqlang
- Yedekni bir necha joyda saqlang (cloud storage, USB, va h.k.)

## 5. Muammo hal qilish

Agar build paytida xatolik bo'lsa:
1. `key.properties` fayl to'g'ri joyda ekanligini tekshiring (`android/key.properties`)
2. `storeFile` yo'lini to'g'ri kiriting (nisbiy yo'l `../app/upload-keystore.jks`)
3. Parollar to'g'ri ekanligini tekshiring
4. Keystore fayl mavjudligini tekshiring
