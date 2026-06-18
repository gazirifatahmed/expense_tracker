import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'views/dashboard_screen.dart';

void main() async {
  // Flutter binding নিশ্চিত করা
  WidgetsFlutterBinding.ensureInitialized();
  
  // Hive ইনিশিয়ালি সেশন এবং লোকাল বক্স ওপেন করা
  await Hive.initFlutter();
  await Hive.openBox('expense_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Personal Expense Tracker',
      debugShowCheckedModeBanner: false,
      // থিম সেটআপ
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light, // Default theme
      home: DashboardScreen(),
    );
  }
}