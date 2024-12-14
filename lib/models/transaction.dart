// models/transaction.dart
class Transaction {
  String
      type; // e.g., "deposit", "withdrawal", "transfer", "bill_payment", "charity"
  String
      recipient; // This can be the service type or recipient for other transactions
  double amount; // Amount involved in the transaction
  DateTime date; // Date of the transaction

  Transaction({
    required this.type,
    required this.recipient,
    required this.amount,
    DateTime? date, // Make date an optional parameter
  }) : date = date ?? DateTime.now(); // Default to now if no date provided

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'recipient': recipient,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  static Transaction fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json['type'],
      recipient: json['recipient'],
      amount: json['amount'],
      date: DateTime.parse(json['date']), // Deserialize date from string
    );
  }
}
