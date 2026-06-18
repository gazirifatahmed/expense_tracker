class TransactionModel {
  String id;
  String title;
  double amount;
  String type; // 'Income' অথবা 'Expense'
  DateTime date;
  String note;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    this.note = '',
  });

  // Hive-এ অবজেক্ট সেভ করার জন্য Map-এ রূপান্তর
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  // Hive থেকে ডাটা নিয়ে অবজেক্টে রূপান্তর
  factory TransactionModel.fromMap(Map<dynamic, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      note: map['note'] ?? '',
    );
  }
}