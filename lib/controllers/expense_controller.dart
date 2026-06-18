import 'package:flutter/material.dart'; // এই ইমপোর্টটি যুক্ত করা হয়েছে এরর ফিক্স করার জন্য
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model.dart';

class ExpenseController extends GetxController {
  var transactions = <TransactionModel>[].obs;
  
  // থিম চেঞ্জের জন্য অবজারভেবল ভ্যারিয়েবল (Bonus: Dark Mode)
  var isDarkMode = false.obs;

  // Hive বক্সের নাম
  final String _boxName = "expense_box";

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  // Hive থেকে সব ডাটা লোড করা (Read)
  void loadTransactions() {
    var box = Hive.box(_boxName);
    var keys = box.keys;
    List<TransactionModel> tempList = [];
    
    for (var key in keys) {
      var data = box.get(key);
      if (data != null) {
        tempList.add(TransactionModel.fromMap(data));
      }
    }
    
    // তারিখ অনুযায়ী সর্ট করা (নতুন ট্রানজেকশন উপরে থাকবে)
    tempList.sort((a, b) => b.date.compareTo(a.date));
    transactions.assignAll(tempList);
  }

  // নতুন ট্রানজেকশন যোগ করা (Create)
  void addTransaction(TransactionModel transaction) {
    var box = Hive.box(_boxName);
    box.put(transaction.id, transaction.toMap());
    transactions.insert(0, transaction);
    loadTransactions(); // রিফ্রেশ ডাটা
  }

  // ট্রানজেকশন আপডেট করা (Update)
  void updateTransaction(TransactionModel updatedTransaction) {
    var box = Hive.box(_boxName);
    box.put(updatedTransaction.id, updatedTransaction.toMap());
    loadTransactions();
  }

  // ট্রানজেকশন ডিলিট করা (Delete)
  void deleteTransaction(String id) {
    var box = Hive.box(_boxName);
    box.delete(id);
    transactions.removeWhere((element) => element.id == id);
    loadTransactions();
  }

  // মোট আয় (Total Income) হিসাব
  double get totalIncome {
    return transactions
        .where((t) => t.type == 'Income')
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  // মোট খরচ (Total Expense) হিসাব
  double get totalExpense {
    return transactions
        .where((t) => t.type == 'Expense')
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  // বর্তমান ব্যালেন্স (Net Balance)
  double get totalBalance => totalIncome - totalExpense;

  // সর্বশেষ ৫টি ট্রানজেকশন ফিল্টার
  List<TransactionModel> get recentTransactions {
    return transactions.take(5).toList();
  }

  // থিম টগল ফাংশন
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}