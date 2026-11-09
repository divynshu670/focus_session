# Focus Sessions

A simple Flutter productivity application that helps users stay focused through timed work sessions and track their productivity history.

## Features

- Start focus sessions of 15, 25 or 45 minutes.
- Live countdown timer.
- Stop focus sessions early.
- Add a note describing completed work.
- View previous sessions in chronological order.
- Swipe to delete individual sessions.
- Persist sessions locally across application restarts.
- Fetch a random motivational quote from ZenQuotes.
- Display a fallback quote when the API is unavailable.
- Loading and error states for quote fetching.

## Screenshots

Add application screenshots here before submission.

## Technology Stack

| Technology | Purpose |
|---|---|
| Flutter 3.38.5 | Cross-platform framework |
| Dart 3.10.4 | Programming language |
| Provider | State management |
| shared_preferences | Local persistence |
| http | REST API requests |
| Material 3 | Application UI |
| flutter_test | Unit and widget testing |

## Architecture

The application follows a simple separation of responsibilities.

```text
lib/
├── models/
│   └── focus_session.dart
├── providers/
│   ├── session_provider.dart
│   └── quote_provider.dart
├── repositories/
│   ├── session_repository.dart
│   └── quote_repository.dart
├── screens/
│   ├── home_screen.dart
│   └── history_screen.dart
├── widgets/
│   ├── focus_timer.dart
│   ├── quote_card.dart
│   └── session_card.dart
└── legacy/
    └── streak_counter.dart
```

### State Management: Provider

Provider was selected because it is lightweight, easy to understand and suitable for a small application.

It separates application state and business logic from UI widgets.

### Persistence: shared_preferences

shared_preferences was selected because the application stores a relatively small amount of structured session data.

Sessions are serialized into JSON and stored locally. This avoids the complexity of introducing a database for this assignment.

### Timer Logic

The timer uses timestamps to calculate elapsed and remaining time rather than relying exclusively on decrementing a counter.

This helps maintain accurate elapsed-time calculations when the application is temporarily suspended.

## API Integration

The application uses the ZenQuotes random quote endpoint:

https://zenquotes.io/api/random

The quote provider handles loading, successful responses and errors. A predefined fallback quote is displayed when the API request fails.

## Getting Started

### Prerequisites

- Flutter 3.x stable
- Dart SDK
- Android Studio or VS Code
- Android SDK

### Installation

Clone the repository:

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

Navigate to the project:

```bash
cd focus_sessions
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## Running Tests

Run all tests:

```bash
flutter test
```

Check code quality:

```bash
flutter analyze
```

## Part 2: StreakCounter

The legacy StreakCounter implementation was corrected to handle:

- Calendar-day comparison independent of time of day.
- Duplicate sessions on the same day.
- Zero streak when no session exists today.
- Consecutive-day calculation.

Tests are provided in:

```text
test/legacy/streak_counter_test.dart
```

## Current Test Status

The initial implementation passed all 9 tests, and `flutter analyze` reported zero issues.

Run the commands above again against the final submitted version.

## Known Limitations

- Local notifications are not implemented.
- Weekly productivity charts are not implemented.
- The application does not include a backend or user authentication.
- Quote availability depends on the external API and internet connectivity.
- The application does not guarantee background execution or notification delivery.

## Screen Recording

Add your 2–3 minute application walkthrough link here:

**Demo:** [Add recording link]

## Author

Divyanshu

