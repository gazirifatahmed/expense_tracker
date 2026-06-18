import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/expense_controller.dart';
import '../models/transaction_model.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;
  const EditTransactionScreen({super.key, required this.transaction});

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final ExpenseController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  late String _selectedType;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.transaction.title);
    _amountController = TextEditingController(text: widget.transaction.amount.toString());
    _noteController = TextEditingController(text: widget.transaction.note);
    _selectedType = widget.transaction.type;
    _selectedDate = widget.transaction.date;
  }

  // মেমোরি লিক রোধ করার জন্য কন্ট্রোলারগুলো ডিসপোজ করা ভালো অভ্যাস
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
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _updateData() {
    if (!_formKey.currentState!.validate()) return;

    final updatedTx = TransactionModel(
      id: widget.transaction.id,
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      type: _selectedType,
      date: _selectedDate,
      note: _noteController.text,
    );

    controller.updateTransaction(updatedTx);
    Get.back();
    Get.snackbar(
      'Updated', 
      'Transaction updated successfully!', 
      snackPosition: SnackPosition.BOTTOM, 
      backgroundColor: Colors.blue.withOpacity(0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Transaction')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
                validator: (value) => value!.isEmpty ? 'Please enter an amount' : null,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // এখানে 'spaceBetween' ফিক্স করা হয়েছে
                children: [
                  Text('Date: ${DateFormat('dd MMMM, yyyy').format(_selectedDate)}', style: const TextStyle(fontSize: 16)),
                  TextButton(onPressed: _presentDatePicker, child: const Text('Change Date', style: TextStyle(fontWeight: FontWeight.bold))),
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  onPressed: _updateData,
                  child: const Text('Update Transaction', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}