import 'package:flutter/material.dart'; // এখানে iimport টাইপোটি ফিক্স করা হয়েছে
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/expense_controller.dart';
import '../models/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final ExpenseController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String _selectedType = 'Income';
  DateTime _selectedDate = DateTime.now();

  // মেমোরি লিক রোধ করার জন্য কন্ট্রোলারগুলো ডিসপোজ করার মেথড যুক্ত করা হলো
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    if (!_formKey.currentState!.validate()) return;

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    final newTx = TransactionModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: enteredTitle,
      amount: enteredAmount,
      type: _selectedType,
      date: _selectedDate,
      note: _noteController.text,
    );

    controller.addTransaction(newTx);
    Get.back();
    Get.snackbar(
      'Success', 
      'Transaction added successfully!', 
      snackPosition: SnackPosition.BOTTOM, 
      backgroundColor: Colors.green.withOpacity(0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Transaction Title', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount (৳)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter an amount';
                  if (double.tryParse(value) == null) return 'Please enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
                items: ['Income', 'Expense'].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // এখানে spaceBetween প্রপার্টি নিশ্চিত করা হলো
                children: [
                  Text('Date: ${DateFormat('dd MMMM, yyyy').format(_selectedDate)}', style: const TextStyle(fontSize: 16)),
                  TextButton(onPressed: _presentDatePicker, child: const Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Note (Optional)', border: OutlineInputBorder()),
                maxLines: 2,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  onPressed: _submitData,
                  child: const Text('Add to List', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}