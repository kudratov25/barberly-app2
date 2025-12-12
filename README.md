# Barberly Mobile App

A modern Flutter mobile application for a barbershop marketplace & management system.

## Features

- ✅ Authentication (Login, Register, Logout)
- ✅ Shops listing + details + workers
- ✅ Barbers (nearest, schedule, status)
- ✅ Services
- ✅ Orders (list, create, start, finish, cancel)
- ✅ Walk-in sessions
- ✅ Chats + messages (API-based)
- ✅ Ratings
- ✅ Stats (daily / monthly / admin)
- ✅ User profile & location updates

## Tech Stack

- **Flutter 3** with Material 3
- **Riverpod** for state management
- **Dio** for API networking
- **go_router** for navigation
- **freezed** + **json_serializable** for models
- **SharedPreferences** for token storage

## Project Structure

```
lib/
  api/              # API client and endpoints
  common/           # Shared utilities, widgets, theme, providers
  features/         # Feature modules
    auth/           # Authentication
    shops/          # Shops management
    services/       # Services
    barbers/        # Barbers management
    orders/         # Orders management
    walkin/         # Walk-in sessions
    chats/          # Chat functionality
    ratings/        # Ratings
    stats/          # Statistics
    profile/         # User profile
  screens/          # Main screens (splash, home)
```

## Setup

1. Install dependencies:
```bash
flutter pub get
```

2. Generate code (freezed, json_serializable):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Update API base URL in `lib/api/endpoints.dart`:
```dart
static const String baseUrl = 'http://your-api-url';
```

4. Run the app:
```bash
flutter run
```

## API Configuration

The app uses Laravel Sanctum for authentication. Make sure your backend API is running and accessible.

Update the base URL in `lib/api/endpoints.dart` to match your backend server.

## Testing

Run tests:
```bash
flutter test
```

## Architecture

- **Clean Architecture**: Separation of concerns with feature modules
- **State Management**: Riverpod providers for dependency injection and state
- **Navigation**: go_router for declarative routing
- **API Layer**: Dio with interceptors for auth and error handling
- **Models**: Freezed for immutable data classes with JSON serialization

## Notes

- All API requests include Bearer token authentication automatically
- 401 errors trigger automatic logout and redirect to login
- Token is stored securely using SharedPreferences
- Material 3 design with modern blue theme
