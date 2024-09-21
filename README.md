# LingoPanda

 The app leverages Firebase for authentication and remote configuration, Hive for local storage, cloud firestore and other packages to ensure a seamless and efficient user experience.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Dependencies](#dependencies)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Technical Details](#technical-details)
- [Contributing](#contributing)
- [License](#license)

## Features

- User Authentication (Sign Up, Login, Logout)
- Fetching and displaying news headlines
- Offline support with local caching
- Remote configuration for dynamic settings
- Responsive and adaptive UI

## Architecture

LingoPanda follows a clean architecture approach, ensuring separation of concerns and scalability. The architecture is divided into three main layers:

1. **Presentation Layer**: Contains the UI components and state management.
2. **Domain Layer**: Contains business logic and domain entities.
3. **Data Layer**: Handles data fetching, caching, and storage.

### Presentation Layer

The presentation layer is responsible for displaying the UI and handling user interactions. It uses the `Provider` package for state management.

Key components:
- `SignupScreen`: Handles user registration.
- `LoginScreen`: Handles user login.
- `NewsPage`: Displays the list of news articles.

### Domain Layer

The domain layer contains the business logic and domain entities. It defines the use cases and repository interfaces.

Key components:
- `NewsModel`: Represents a news article.
- `AuthRepository`: Interface for authentication operations.
- `NewsRepository`: Interface for news operations.

### Data Layer

The data layer is responsible for data fetching, caching, and storage. It includes remote data sources (e.g., Firebase, REST APIs) and local data sources (e.g., Hive).

Key components:
- `AuthRemoteDataSource`: Handles authentication with Firebase.
- `NewsRemoteDataSource`: Fetches news from a remote API.
- `AuthLocalDataSource`: Manages local storage of user data.
- `NewsLocalDataSource`: Manages local storage of news articles.

## Dependencies

- Flutter
- Firebase Auth
- Firebase Core
- Firebase Remote Config
- Hive
- Dio
- Provider
- Google Fonts

## Getting Started

To get started with LingoPanda, follow these steps:

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/lingopanda.git
    cd lingopanda
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Set up Firebase**:

    - Add the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files to the respective directories.

4. **Run the app**:
    ```bash
    flutter run
    ```

## Project Structure

The project is organized as follows:
