Focus Sessions

Project Overview

Build Focus Sessions, a single-user Flutter productivity application for running timed focus sessions and reviewing session history.

Target platform: Android.
Framework: Flutter 3.x stable.
Language: Dart.

Technology Choices

State management: Provider.

Local persistence: shared_preferences.

HTTP networking: http.

UI: Material 3.

Testing: flutter_test.

Do not introduce additional dependencies without asking first.

Project Architecture

Keep responsibilities separated:

lib/models/: Data models and serialization.

lib/providers/: Application state and business logic.

lib/repositories/: Local persistence and API access.

lib/screens/: Application screens.

lib/widgets/: Reusable UI components.

lib/legacy/: Legacy code supplied by the assignment.

Keep business logic out of UI widgets.

Coding Conventions

Follow standard Dart and Flutter conventions.

Use snake_case for filenames.

Use PascalCase for classes.

Use camelCase for variables and methods.

Prefer const constructors wherever possible.

Write small, readable and maintainable methods.

Add comments only when they clarify non-obvious logic.

Handle loading, error and empty states.

Avoid unnecessary abstractions and over-engineering.

State Management Rules

Use Provider consistently for shared application state.

Do not use setState for shared application state.

Keep timer, session and quote business logic outside widgets.

Dispose timers and other resources correctly.

Timer Requirements

Support 15, 25 and 45-minute sessions.

Calculate elapsed and remaining time using timestamps.

Support early session termination.

Preserve accurate timing across application backgrounding and resuming.

Persistence Requirements

Store sessions locally using shared_preferences.

Serialize and deserialize session data safely.

Display sessions newest first.

Support deleting individual sessions.

API Requirements

Fetch a random motivational quote from a public API.

Handle loading, success, errors and offline states.

Display a fallback quote when the request fails.

Testing Requirements

Write unit tests for session models and business logic.

Write widget tests for the history screen.

Test StreakCounter edge cases.

Run flutter test after meaningful changes.

Git Rules

Work in small, logical steps.

Use meaningful commit messages.

Do not squash all work into one commit.

Never commit unfinished or unverified code as completed.

Important Restrictions

Do not generate the entire application in one response.

Do not overwrite existing files without inspecting them.

Do not modify unrelated files.

Do not add packages without approval.

Do not use placeholder implementations for required features.

Do not claim tests pass unless they have actually been executed.

Explain important architectural decisions.

Ask before making changes outside the requested scope.

Development Workflow

For every task:

Inspect relevant existing files.

Understand the requested change.

Implement only the requested feature.

Add or update relevant tests.

Explain changed files and important decisions.

Report commands that should be executed for verification.

Wait for feedback before moving to an unrelated feature.