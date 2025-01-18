# Domain Layer

This directory contains the domain layer of Immich. The domain layer is responsible for the business logic of the app. It includes entities, services, repositories, and utilities. This layer should never depend on anything from the presentation layer or from Flutter.

## Structure

- **Entities**: These are the classes that define the database schema for the domain models.
- **Models**: These are the core data classes that represent the business models.
- **Interfaces**: These are the interfaces that define the contract for data operations.
- **Repositories**: These are the actual implementation of the domain interfaces. A single interface might have multiple implementations.
- **Services**: These are the classes that contain the business logic and interact with the repositories.
- **Providers**: These are the Riverpod providers for the service classes and repository classes.
- **Utils**: These are utility classes and functions that provide common functionalities used across the domain layer.

## Folder Contents

- [`entities/`](./entities/): Contains the entity classes.
- [`models/`](./models/): Contains the core data classes.
- [`interfaces/`](./interfaces/): Contains the interface definitions.
- [`repositories/`](./repositories/): Contains the repository interfaces.
- [`services/`](./services/): Contains the service classes.
- [`providers/`](./providers/): Contains the Riverpod providers.
- [`utils/`](./utils/): Contains utility classes and functions.

## Example

Here is an example of how the domain layer is structured:

```
domain/
├── entities/
│   └── user.entity.dart
├── models/
│   └── user.model.dart
├── interfaces/
│   └── user.interface.dart
├── repositories/
│   └── user.repository.dart
├── services/
│   └── user.service.dart
├── providers/
│   └── user.provider.dart
└── utils/
    └── date_utils.dart
```

## Usage

To use the domain layer, you will typically call a service from the presentation layer through the provider, which will interact with the repository to fetch or manipulate data.

```dart
// Using riverpod
final userService = ref.watch(userServiceProvider);
final userProfile = await userService.getUserProfile(userId);
```

Make sure to implement the repository interfaces in the domain layer to provide the actual data operations.
