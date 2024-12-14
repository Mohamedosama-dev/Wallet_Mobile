// screens/transactions_page.dart
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/shared_preferences_service.dart';

class TransactionsPage extends StatelessWidget {
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transactions")),
      body: FutureBuilder<List<Transaction>>(
        future: sharedPreferencesService.getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading transactions."));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No transactions available."));
          }

          List<Transaction> transactions = snapshot.data!;

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              Transaction transaction = transactions[index];
              return ListTile(
                title: Text(transaction.type.toUpperCase()),
                subtitle: Text(
                  transaction.recipient != null &&
                          transaction.recipient.isNotEmpty
                      ? "To: ${transaction.recipient}"
                      : "No recipient specified",
                ),
                trailing: Text("\$${transaction.amount.toStringAsFixed(2)}"),
                leading: Text(
                  "${transaction.date.toLocal().toString().split(' ')[0]} \n ${transaction.date.toLocal().toString().split(' ')[1].substring(0, 5)}", // Display the date and time
                  style: TextStyle(fontSize: 12),
                ),
              );
            },
          );
        },
      ),
      // Back to Dashboard Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context); // Navigate back to the previous screen
        },
        label: Text("Back to Dashboard"),
        icon: Icon(Icons.arrow_back), // Optional icon for the button
      ),
    );
  }
}
