# FeastWealth – Premium Personal Expense Tracker

FeastWealth is a high-performance, cross-platform personal finance management mobile application built with Flutter. It features a sleek, premium fintech user interface that empowers users to seamlessly track income and expenses, visualize real-time analytics, and manage daily records efficiently with zero latency.

---

## ✨ Features

- **Premium UI/UX:** Glassmorphic dual-theme (Light/Dark mode) dashboard with vibrant mixed-gradient accents.
- **Real-time Analytics:** Interactive and dynamic charts for visual financial tracking.
- **Offline-First:** Fast NoSQL local data persistence using Hive DB, ensuring security and availability without internet.
- **Immersive Engagement:** Customized audio triggers on application initialization to elevate user experience.
- **Clean Architecture:** Structured using the MVC pattern for highly scalable and maintainable code.

---

## 📱 App Screenshots

Here is a glimpse of the premium UI designed for both Light and Dark modes:

<p align="center">
  <img src="https://github.com/user-attachments/assets/6e5b6c63-18bd-40f5-8dea-7747491422ac" width="19%" alt="Dashboard Light Mode" />
  <img src="https://github.com/user-attachments/assets/14e01b99-8600-4396-b59a-f8a9d50e9abf" width="19%" alt="Dashboard Dark Mode" />
  <img src="https://github.com/user-attachments/assets/d530a955-8736-45ec-b4e8-1d980d7fd48d" width="19%" alt="Add Transaction" />
  <img src="https://github.com/user-attachments/assets/6b01457b-13de-4307-928f-64eb672edc2d" width="19%" alt="All Transactions" />
  <img src="https://github.com/user-attachments/assets/eb24335e-5326-4412-8dbf-de004b46e4ad" width="19%" alt="Analytics Screen" />
</p>

---

## 🛠️ Tech Stack

- **Framework:** Flutter (Dart)
- **State Management:** GetX (Reactive & Dependency Injection)
- **Database:** Hive DB (NoSQL Local Storage)
- **Charts:** FL Chart
- **Audio:** Audioplayers
- **Formatting:** Intl (Currency & Date formatting)

---

## 📁 Project Structure

```text
lib/
├── controllers/
│   ├── expense_controller.dart  # Business logic & Hive operations
│   └── audio_controller.dart    # App opening sound handler
├── models/
│   └── transaction_model.dart   # Hive TypeAdapter data model
├── views/
│   ├── dashboard_screen.dart    # Main hub with balance & floating button
│   ├── statistics_screen.dart   # Premium analytics charts
│   ├── add_transaction_screen.dart # Data input form
│   └── widgets/
│       └── transaction_tile.dart   # Reusable list item card
└── main.dart                     # App entry point & Initialization


🚀 Getting Started & Setup Commands
Follow these steps to run the project locally on your machine:

1. Prerequisites
Ensure you have the Flutter SDK installed and configured. Minimum SDK requirement:

YAML
environment:
  sdk: '>=3.0.0 <4.0.0'
2. Installation
Clone the repository and navigate to the project root directory:

Bash
git clone [https://github.com/your-username/expense_tracker.git](https://github.com/your-username/expense_tracker.git)
cd expense_tracker
3. Fetch Dependencies
Install all required packages listed in pubspec.yaml:

Bash
flutter pub get
4. Code Generation (Hive Adapters)
Generate the necessary Hive TypeAdapters for permanent storage:

Bash
flutter pub run build_runner build --delete-conflicting-outputs
5. Clean & Run the Application
If you face any asset synchronization issues or want to do a fresh launch, run:

Bash
flutter clean
flutter pub get
flutter run
📄 License
This project is open-source and available under the MIT License.
