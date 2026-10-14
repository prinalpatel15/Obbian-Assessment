# Obbian-Assessment
practical assessment

# Obbian Assessment — Flutter

A Flutter application developed as part of the Obbian technical assessment. The app provides a home screen where users can explore a Web View experience and a native Flutter App View.

## Features

- **Home Screen:** Entry point for navigating between the available views.
- **Web View:** Loads a website inside the app, displays loading progress, and supports browser back navigation.
- **App View:** Provides a native Flutter UI experience.
- **Responsive UI:** Uses `flutter_screenutil` for responsive sizing.
- **Reusable Structure:** Organizes the application into app configuration, routes, core components, and feature-specific code.

## Tech Stack

- Flutter and Dart
- Material Design
- `webview_flutter` — embedded web content
- `flutter_screenutil` — responsive sizing
- `flutter_svg` — SVG assets

## Prerequisites

Before running the application, install:

- Flutter SDK
- Android Studio and Android SDK, or Xcode for iOS development
- An Android emulator, iOS simulator, or connected device

Verify your Flutter environment:

```bash
flutter doctor
```

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/prinalpatel15/Obbian-Assessment.git
cd Obbian-Assessment
```

### 2. Check out the assessment branch

```bash
git checkout develop
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Check available devices

```bash
flutter devices
```

### 5. Run the application

```bash
flutter run
```

### Run using Android Studio

1. Open the cloned project folder in Android Studio.
2. Wait for Flutter dependencies to resolve.
3. Start an emulator or connect an Android device.
4. Select the target device.
5. Click **Run**.

## Project Structure

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── routes.dart
├── core/
│   ├── constants/
│   ├── theme/
│   └── widgets/
└── features/
    ├── home/
    ├── web_view/
    └── app_view/

assets/
├── fonts/
├── icons/
└── images/

test/
└── widget_test.dart
```

### Important Files

| File | Responsibility |
|---|---|
| `lib/main.dart` | Application entry point |
| `lib/app/app.dart` | App configuration, theme, and initial route |
| `lib/app/routes.dart` | Named route registration |
| `lib/features/home/presentation/home_screen.dart` | Home screen and navigation |
| `lib/features/web_view/presentation/web_view_screen.dart` | Web View controller and navigation |
| `lib/core/constants/app_constants.dart` | Web View URL configuration |

## Web View Configuration

The default website is configured in `lib/core/constants/app_constants.dart`:

```dart
webViewUrl = 'https://flutter.dev';
```

Update this value to load another website.

An internet connection is required to load remote web content.

## Run Tests

Run the Flutter test suite:

```bash
flutter test
```

Check code for potential issues:

```bash
flutter analyze
```

## Authentication and Backend

The current repository demonstrates the view-switching UI and Web View integration. It does not currently include a login screen, authentication API, backend integration, or access/refresh-token management.

No backend credentials or API keys are required to run the default demo.

## Author

Developed for the Obbian Flutter technical assessment.
