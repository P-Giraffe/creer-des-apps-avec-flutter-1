# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter counter application ("Mon Super Compteur" / "Mes Petits Totaux") used as an educational project for learning Flutter basics. It demonstrates a clean three-layer architecture (UI / models / data source), StatefulWidget, and Material Design components.

## Common Commands

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Run tests
flutter test

# Run a specific test file
flutter test test/widget_test.dart

# Analyze code for errors and lints
flutter analyze

# Format code
dart format lib/
```

## Architecture

The app is organized in **three logical layers** under `lib/`. This separation is
**mandatory** and MUST be respected for every future addition.

```
lib/
├── main.dart          # Entry point: builds the dependency chain (data source → service → router) and injects it
├── ui/                # Graphical layer ONLY: screens, widgets, navigation (router)
├── models/            # Data models + management layer (services/controllers). Pure Dart, no Flutter imports
└── data_source/       # Each main data source (database, web service…). At the very end of the chain
```

### Layer responsibilities & dependency rule

Dependencies flow in **one direction only**:

```
UI  →  service (models)  →  data source
         ↑ uses the data model (models)
```

- **UI (`lib/ui/`)** — Only the graphical part: screens, widgets, routing. It talks
  **exclusively to a service** from the `models/` layer. The UI MUST NEVER import or
  call a class from `data_source/` directly.
- **models (`lib/models/`)** — Two kinds of classes, framework-agnostic (no
  `package:flutter/...` imports):
  - **Data models** (e.g. `counter.dart`): immutable, hold data + their own business
    logic (e.g. `isGoalReached`), expose `copyWith`.
  - **Services/controllers** (e.g. `counter_service.dart`): the **mandatory intermediary**
    between UI and data sources. They carry business operations (increment, rename…) and
    delegate persistence to a data source injected via the constructor.
- **data_source (`lib/data_source/`)** — Code managing each real data source (database,
  web service). At the very end of the chain, **used only by services**. APIs are
  **asynchronous** (`Future`) to match real databases/web services. The current
  `CounterDatabaseDataSource` is a placeholder (in-memory variable) not yet backed by a
  real database.

### Rules for new features

- Add a new screen/widget under `lib/ui/`; it receives its service(s) via constructor injection.
- Put new data structures and business logic under `lib/models/` (model + service).
- Add a new data source class under `lib/data_source/` with an async API; wire it into a
  service, never directly into the UI.
- Build the dependency chain in `main.dart` and inject the **service** (never the data
  source) down through the router into the screens.
- Keep model and service code free of any Flutter import.

## Testing

Widget tests are located in `test/`; pure unit tests for models and services live under
`test/models/`. The project uses `flutter_test` for testing and `flutter_lints` for static
analysis. Each new model, service, and data source MUST come with its own tests.
