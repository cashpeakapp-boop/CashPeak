# CashPeak Android App

Flutter source project for the CashPeak rewards app prototype.

## Included
- CashPeak splash screen using the supplied logo
- Home dashboard
- Earn/tasks screen
- Local balance and reward actions
- Wallet and withdrawal dialog
- Transaction history sample
- Profile/settings screen
- Bottom navigation

## Build APK
Install Flutter 3.x and Android Studio/SDK, then from this folder run:

```bash
flutter pub get
flutter build apk --release
```

APK output:
`build/app/outputs/flutter-apk/app-release.apk`

This build is a functional front-end prototype. Real authentication, server/database, payouts, and ad-network integration require backend/API credentials and should be connected before production release.
