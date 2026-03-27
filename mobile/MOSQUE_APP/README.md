# 🕌 Mosque App (Flutter)
<img width="1024" height="500" alt="Rock Paper Scissors (2)" src="https://github.com/user-attachments/assets/96832ca5-17ac-433c-97ae-b0480ba57265" />


A modern, beautiful, and offline-first Islamic Mosque App built with Flutter.
The app provides accurate prayer times, Qibla compass, zikr counter, Arabic & English support, and a spiritually calm user experience.

## ✨ Features
### 🕰 Prayer Times

- Accurate prayer times calculated locally
- Shows next prayer and countdown
- Date switching (previous / next day)
- Manual prayer time adjustments
- Local prayer notifications

### 🧭 Qibla Compass
- Real sensor-based compass
- Accurate Qibla direction using user location
- Smooth rotation
- Works offline

### 📿 Zikr Counter
- Presets: 33 / 99
- Custom zikr count
- Circular tap counter
- Progress indicator
- Reset button
- Saved automatically

### ⚙️ Settings
- Dark / Light mode
- Arabic / English language
- Manual prayer time offsets
- Persistent settings

### 🌍 Localization
- Full Arabic translation
- Automatic RTL / LTR layout
- Clean typography for Arabic & English
### 📱 Offline-First
- Prayer times work without internet
- Qibla works offline
- Graceful handling of permissions & errors

### 🎨 UI & Design
- Islamic color palette (teal & gold)
- Elegant gradients
- Arabic calligraphy support
- Calm, minimal, respectful design
- Optimized for daily spiritual use

### 🛠 Tech Stack
- Flutter
- Provider – state management
- Adhan – prayer time calculation
- Geolocator / Geocoding – location
- Flutter Compass – Qibla direction
- Flutter Local Notifications
- SharedPreferences – local storage
- Intl – localization
- Connectivity Plus – offline detection

## 📂 Project Structure

```css
lib/
├── core/
│   ├── notifications/
│   ├── qibla/
│   ├── storage/
│   └── network/
│
├── providers/
│   ├── prayer_provider.dart
│   ├── theme_provider.dart
│   ├── language_provider.dart
│   └── counter_provider.dart
│
├── pages/
│   ├── prayer_page.dart
│   ├── qibla_page.dart
│   ├── counter_page.dart
│   └── settings_page.dart
│
├── widgets/
│   ├── header_widget.dart
│   └── error_state.dart
│
├── l10n/
│   ├── app_en.arb
│   └── app_ar.arb
│
├── app.dart
└── main.dart
```

## 🚀 Getting Started
### 1️⃣ Prerequisites
- Flutter SDK (latest stable)
- Android Studio / Xcode
- Android or iOS device / emulator

### 2️⃣ Clone the Repository
```bash
git clone https://github.com/your-username/mosque-app.git
cd mosque-app
```

### 3️⃣ Install Dependencies
```bash
flutter pub get
```

### 4️⃣ Run the App
```bash
flutter run
```

## 🔐 Permissions Used
| Permission |	Purpose |
-------------------------
| Location |	Prayer times & Qibla <br>
| Notifications |	Prayer reminders

👉 No personal data is stored or shared.

## 🌐 Supported Languages

- English 🇬🇧
- Arabic 🇸🇦 (RTL supported)
- Russian ru
- Uzbek uz

## 📸 Screenshots
<img width="200" alt="Screenshot_20260118_182116" src="https://github.com/user-attachments/assets/6de4f369-4594-4eae-9b82-a17cfa0c3523" />
<img width="200" alt="Screenshot_20260118_182109" src="https://github.com/user-attachments/assets/baf71666-4d2b-4aed-8f52-3adb292ad75c" />
<img width="200" alt="Screenshot_20260118_182102" src="https://github.com/user-attachments/assets/4e31ba7b-cbe4-46c8-b822-b92ee94c1087" />
<img width="200" alt="Screenshot_20260118_182037" src="https://github.com/user-attachments/assets/ce96e62b-86c4-4eef-ae9f-f592e2115756" />

## 🧪 Tested Scenarios
- Offline mode
- Location denied
- Compass unavailable
- Dark / Light mode
- Arabic RTL layout

## 📦 Build for Release
Android
```bash
flutter build appbundle
```
iOS
```bash
flutter build ios
```

## 🔒 Privacy Policy

This app:
- Uses location only for prayer time and Qibla calculation
- Does not collect or share personal data
- Works fully offline

## 🤝 Contributing
Contributions are welcome! <br>
Please open an issue or submit a pull request.

## 📜 License
This project is licensed under the MIT License.

## 🕌 Acknowledgment
Built with respect for Islamic principles and daily spiritual needs.

<b>“Indeed, prayer prohibits immorality and wrongdoing.”</b>
— Quran 29:45

## ⭐ Support

If you like this project, please consider giving it a ⭐ on GitHub.
