import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/expense_controller.dart';

class StatisticsScreen extends StatelessWidget {
  final ExpenseController controller = Get.find();

  StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monthly Statistics')),
      body: Obx(() {
        double income = controller.totalIncome;
        double expense = controller.totalExpense;
        double total = income + expense;

        if (total == 0) {
          return const Center(child: Text('Add transaction data to view statistics.'));
        }

        double incomePercent = (income / total) * 100;
        double expensePercent = (expense / total) * 100;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Income vs Expense Ratio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 50,
                    sections: [
                      PieChartSectionData(color: Colors.green, value: income, title: '${incomePercent.toStringAsFixed(1)}%', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      PieChartSectionData(color: Colors.red, value: expense, title: '${expensePercent.toStringAsFixed(1)}%', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegend(color: Colors.green, text: 'Income (৳${income.toStringAsFixed(1)})'),
                  _buildLegend(color: Colors.red, text: 'Expense (৳${expense.toStringAsFixed(1)})'),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLegend({required Color color, required String text}) {
    return Row(
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}