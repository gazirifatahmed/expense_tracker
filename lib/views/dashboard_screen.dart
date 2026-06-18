import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/expense_controller.dart';
import 'add_transaction_screen.dart';
import 'transaction_list_screen.dart';
import 'statistics_screen.dart';

class DashboardScreen extends StatelessWidget {
  final ExpenseController controller = Get.put(ExpenseController());

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Get.to(() => StatisticsScreen()),
          ),
          Obx(() => IconButton(
                icon: Icon(controller.isDarkMode.value ? Icons.light_mode : Icons.dark_mode),
                onPressed: () => controller.toggleTheme(),
              )),
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ব্যালেন্স কার্ড
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade700, Colors.blue.shade400],
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text('Current Balance', style: TextStyle(color: Colors.white70, fontSize: 16)),
                      const SizedBox(height: 8),
                      Text(
                        '৳ ${controller.totalBalance.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // আয় ও খরচের সারসংক্ষেপ
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Total Income',
                      amount: controller.totalIncome,
                      color: Colors.green,
                      icon: Icons.arrow_upward,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Total Expense',
                      amount: controller.totalExpense,
                      color: Colors.red,
                      icon: Icons.arrow_downward,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              
              // সর্বশেষ ৫টি ট্রানজেকশনের হেডার
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // এখানে spaceBetween নিশ্চিত করা আছে
                children: [
                  const Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () => Get.to(() => TransactionListScreen()),
                    child: const Text('See All'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              
              // ট্রানজেকশন লিস্ট
              controller.recentTransactions.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text('No transactions added yet!'),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.recentTransactions.length,
                      itemBuilder: (context, index) {
                        final tx = controller.recentTransactions[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: tx.type == 'Income' 
                                  ? Colors.green.withOpacity(0.2) 
                                  : Colors.red.withOpacity(0.2),
                              child: Icon(
                                tx.type == 'Income' ? Icons.arrow_downward : Icons.arrow_upward,
                                color: tx.type == 'Income' ? Colors.green : Colors.red,
                              ),
                            ),
                            title: Text(tx.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(DateFormat('dd MMM, yyyy').format(tx.date)),
                            trailing: Text(
                              '${tx.type == 'Income' ? '+' : '-'} ৳${tx.amount.toStringAsFixed(1)}',
                              style: TextStyle(
                                color: tx.type == 'Income' ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTransactionScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title, 
    required double amount, 
    required Color color, 
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 4),
                Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '৳ ${amount.toStringAsFixed(1)}',
              style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}