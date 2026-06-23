🍽️ FeastWealth – Premium Personal Expense Tracker
A high-performance, cross-platform personal finance management mobile application built with Flutter.

FeastWealth features a sleek, premium fintech user interface that empowers users to seamlessly track income and expenses, visualize real-time analytics, and manage daily records efficiently with zero latency.

✨ Key Features
🎨 Premium UI/UX: Glassmorphic dual-theme (Light/Dark mode) dashboard with vibrant mixed-gradient accents

📊 Real-time Analytics: Interactive and dynamic charts for visual financial tracking

📴 Offline-First: Fast NoSQL local data persistence using Hive DB, ensuring security and availability without internet

🎵 Immersive Engagement: Customized audio triggers on application initialization to elevate user experience

🏗️ Clean Architecture: Structured using the MVC pattern for highly scalable and maintainable code

💾 Persistent Storage: All transactions are stored locally with Hive for instant access

🌓 Theme Support: Seamless switching between Light and Dark modes

📱 App Screenshots
Here's a glimpse of the premium UI designed for both Light and Dark modes:

Dashboard (Light)	Dashboard (Dark)	Add Transaction	All Transactions	Analytics
<img src="https://github.com/user-attachments/assets/6e5b6c63-18bd-40f5-8dea-7747491422ac" width="100%">	<img src="https://github.com/user-attachments/assets/14e01b99-8600-4396-b59a-f8a9d50e9abf" width="100%">	<img src="https://github.com/user-attachments/assets/d530a955-8736-45ec-b4e8-1d980d7fd48d" width="100%">	<img src="https://github.com/user-attachments/assets/6b01457b-13de-4307-928f-64eb672edc2d" width="100%">	<img src="https://github.com/user-attachments/assets/eb24335e-5326-4412-8dbf-de004b46e4ad" width="100%">
📹 App Demo
Check out the application in action:

https://github.com/user-attachments/assets/26036cd4-27c1-474c-a7a3-a7a1af9d066d

🛠️ Tech Stack
Category	Technology
Framework	Flutter (Dart)
State Management	GetX (Reactive & Dependency Injection)
Database	Hive DB (NoSQL Local Storage)
Charts	FL Chart
Audio	Audioplayers
Formatting	Intl (Currency & Date formatting)
Architecture	MVC Pattern
📁 Project Structure
text
lib/
├── controllers/
│   ├── expense_controller.dart    # Business logic & Hive operations
│   └── audio_controller.dart      # App opening sound handler
├── models/
│   └── transaction_model.dart     # Hive TypeAdapter data model
├── views/
│   ├── dashboard_screen.dart      # Main hub with balance & floating button
│   ├── statistics_screen.dart     # Premium analytics charts
│   ├── add_transaction_screen.dart # Data input form
│   └── widgets/
│       └── transaction_tile.dart  # Reusable list item card
└── main.dart                      # App entry point & initialization
🚀 Getting Started
Follow these steps to run the project locally on your machine:

1. Prerequisites
Ensure you have the Flutter SDK installed and configured. Minimum SDK requirement:

yaml
environment:
  sdk: '>=3.0.0 <4.0.0'
2. Clone the Repository
bash
git clone https://github.com/your-username/feastwealth.git
cd feastwealth
3. Fetch Dependencies
Install all required packages listed in pubspec.yaml:

bash
flutter pub get
4. Generate Hive Adapters
Generate the necessary Hive TypeAdapters for permanent storage:

bash
flutter pub run build_runner build --delete-conflicting-outputs
5. Clean & Run
If you face any asset synchronization issues or want to do a fresh launch:

bash
flutter clean
flutter pub get
flutter run
📦 Dependencies
yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6                    # State Management
  hive_flutter: ^1.1.0           # Local Database
  fl_chart: ^0.68.0              # Charts & Analytics
  audioplayers: ^5.2.1           # Audio Playback
  intl: ^0.18.0                  # Date/Currency Formatting
  google_fonts: ^6.2.1           # Premium Typography
  
dev_dependencies:
  build_runner: ^2.4.9           # Code Generation
  hive_generator: ^2.0.1         # Hive Adapter Generator
🎯 Core Functionality
💰 Transaction Management
Add income/expense with category selection

Edit and delete existing entries

Automatic balance calculation

📊 Analytics Dashboard
Income vs Expense pie chart

Monthly spending trends

Category-wise breakdown

🎨 Customization
Light/Dark theme switching

Currency symbol customization

Category icons and colors

🔮 Future Enhancements
Cloud backup and synchronization

Multi-currency support

Budget planning and alerts

Export data to CSV/PDF

Biometric authentication

Recurring transactions

🤝 Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

Fork the repository

Create your feature branch (git checkout -b feature/AmazingFeature)

Commit your changes (git commit -m 'Add some AmazingFeature')

Push to the branch (git push origin feature/AmazingFeature)

Open a Pull Request

📄 License
This project is open-source and available under the MIT License.

text
MIT License

Copyright (c) 2024 FeastWealth

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
...
👨‍💻 Developer
FeastWealth is developed with ❤️ using Flutter.

GitHub: @your-username

Project Link: https://github.com/your-username/feastwealth

Made with Flutter • Finance Made Simple • Track Your Wealth
