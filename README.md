# 📱 Flutter Articles App

A complete Flutter app for browsing articles with offline support using Hive database.

<img src="https://github.com/user-attachments/assets/7a627917-66e6-430d-93f4-451f136b7688" width="150" />
<img src="https://github.com/user-attachments/assets/8aca5046-4fd6-4c2d-abee-60dc63abf80b" width="150" />
<img src="https://github.com/user-attachments/assets/7f962c98-28be-4146-b8e1-851364d39500" width="150" />
<img src="https://github.com/user-attachments/assets/8e2c6f73-c716-4973-8ddf-6ba6ae01e3e0" width="150" />


## ✨ Features

- **Article Listing** - Fetches from JSONPlaceholder API
- **Offline Support** - Caches articles using Hive
- **Search Functionality** - Client-side filtering
- **Favorite System** - Persists between sessions
- **Pull-to-Refresh** - Easy content updates

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter  |
| State Management | BLoC Pattern |
| Local Database | Hive  |
| Networking | http package |
| DI | GetIt |

## 🧠 State Management

The app uses **BLoC (Business Logic Component)** pattern for predictable state management. Data flows unidirectionally:

1. **UI** dispatches Events (like `FetchArticles`)
2. **BLoC** processes events and interacts with Repository
3. **Repository** coordinates data from API (remote) and Hive (local)
4. **BLoC** emits States (`Loading`, `Loaded`, `Error`)
5. **UI** reacts to state changes and rebuilds

Key benefits:
- Clear separation of concerns
- Easy testing of business logic
- Maintainable state transitions
- Built-in support for async operations

## 💡 Planned Enhancements

- [ ] **UI Layer**:
  - Animated transitions between screens
  - Custom refresh indicator
  - Offline-first design patterns



## 🚀 Quick Start

```bash
# Clone repository
git clone https://github.com/zaidk22/nxt_assignment.git

# Install dependencies
flutter pub get

# Generate Hive adapters
flutter pub run build_runner build

# Run the app
flutter run
