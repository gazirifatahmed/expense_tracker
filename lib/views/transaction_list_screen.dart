import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/expense_controller.dart';
import 'edit_transaction_screen.dart';

class TransactionListScreen extends StatelessWidget {
  final ExpenseController controller = Get.find();

  TransactionListScreen({super.key});

  void _showDeleteDialog(BuildContext context, String id) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Transaction'),
        content: const Text('Are you sure you want to delete this record?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              controller.deleteTransaction(id);
              Get.back();
              Get.snackbar('Deleted', 'Record removed.', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red.withOpacity(0.1));
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Transactions')),
      body: Obx(() {
        if (controller.transactions.isEmpty) {
          return const Center(child: Text('No transaction history found.'));
        }
        return ListView.builder(
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final tx = controller.transactions[index];
            final isIncome = tx.type == 'Income';

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              elevation: 1,
              child: ListTile(
                leading: Icon(
                  isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isIncome ? Colors.green : Colors.red,
                ),
                title: Text(tx.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat('dd MMM yyyy, hh:mm a').format(tx.date)),
                    if (tx.note.isNotEmpty) Text('Note: ${tx.note}', style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${isIncome ? '+' : '-'} ৳${tx.amount.toStringAsFixed(1)}',
                      style: TextStyle(color: isIncome ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                      onPressed: () => Get.to(() => EditTransactionScreen(transaction: tx)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                      onPressed: () => _showDeleteDialog(context, tx.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}