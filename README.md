# Ditonton

[![Codemagic build status](https://api.codemagic.io/apps/63c77d5907f17b0760d99b88/63c77d5907f17b0760d99b87/status_badge.svg)](https://codemagic.io/apps/63c77d5907f17b0760d99b88/default-workflow/latest_build)

## Project Goals
This project was created with the aim of completing the course Dicoding [Menjadi Flutter Developer Expert](https://www.dicoding.com/academies/199)

## Modularization Structure

    # Root Project
    .
    |
    ├── lib                    # Name of module (default from Flutter).
    │
    ├── core                   # Name of module.
    │   ├── database           # Business logic component.
    │   ├── styles             # Color, Text & Theme Styles.
    │   ├── utils              # Util shared.
    │   └── presentation       # UI, Widget, State Management.
    │   
    ├── feature_about          # Name of module.
    │   └── presentation       # UI, Widget, State Management.
    │
    ├── feature_movie          # Name of module.
    │   ├── data               # Local & Remote data, Model, Repository.
    │   ├── domain             # Business logic component (Entities, Usecases).
    │   └── presentation       # UI, Widget, State Management.
    │
    ├── feature_tv             # Name of module.
    │   ├── data               # Local & Remote data, Model, Repository.
    │   ├── domain             # Business logic component (Entities, Usecases).
    │   └── presentation       # UI, Widget, State Management.
    .
    
## Dependencies 🛠
* [BLoC Pattern](https://bloclibrary.dev/) - Business logic component to separate the business logic with UI.
* [SQLite](https://pub.dev/packages/sqflite) - Local Database
* [Equatable](https://pub.dev/packages/equatable) - Being able to compare objects in `Dart` often involves having to override the `==` operator.
* [Json Serializable](https://pub.dev/packages/json_serializable) - Builders for handling JSON.
* [Codemagic](https://blog.codemagic.io/environments-in-flutter-with-codemagic-cicd/) - Handling DevOps CI/CD for pipeline and automatically build.
* [Get It](https://pub.dev/packages/get_it) - A Dependency Injection
