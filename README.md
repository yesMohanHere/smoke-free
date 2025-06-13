# Cigarette Tracker App

This is a simple Flutter mobile application to track cigarette consumption and display analytics locally on the device.

## Features

- Log cigarette consumption with a timestamp.
- View daily, weekly, monthly, and yearly analytics in numerical and graphical formats.
- All data is stored locally on the device and is not collected or shared.

## Project Structure

- `lib/main.dart`: Main application entry point and route definitions.
- `lib/models/cigarette_log.dart`: Data model for a single cigarette log entry.
- `lib/services/local_storage_service.dart`: Handles local data persistence using `shared_preferences`.
- `lib/services/analytics_service.dart`: Provides methods for calculating analytics (daily, weekly, monthly, yearly counts).
- `lib/views/home_screen.dart`: The main screen for logging cigarettes and navigating to analytics.
- `lib/views/analytics_screen.dart`: Displays the numerical and graphical analytics.

## Getting Started

### Prerequisites

- Flutter SDK installed (version 3.22.2 or later recommended).
- A device (Android/iOS) or emulator/simulator to run the app.

### Installation

1. Clone this repository:
   ```bash
   git clone <repository_url>
   cd cigarette_tracker
   ```

2. Get Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Testing

To run the tests, navigate to the project root and execute:

```bash
flutter test
```

## Future Enhancements

- More sophisticated analytics (e.g., average consumption, streaks).
- User interface improvements and customization options.
- Export/import data functionality.
- Notifications/reminders.


