// screens/withdraw_page.dart
import 'package:flutter/material.dart';
import '../services/shared_preferences_service.dart';
import '../models/transaction.dart';

class WithdrawPage extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Withdraw")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String amountString = amountController.text;
                double? amount = double.tryParse(amountString);

                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a valid amount.")),
                  );
                  return;
                }

                double currentBalance =
                    await sharedPreferencesService.getBalance();

                if (amount > currentBalance) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Insufficient balance.")),
                  );
                  return;
                }

                // Update balance after withdrawal
                double newBalance = currentBalance - amount;
                await sharedPreferencesService.saveBalance(newBalance);

                // Save withdrawal transaction
                Transaction transaction = Transaction(
                  type: "withdraw", // Use lowercase for consistency
                  recipient: "ATM", // Specify the recipient
                  amount: amount,
                  date: DateTime.now(), // Pass the current date
                );
                await sharedPreferencesService.saveTransaction(transaction);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Withdrawal successful. New balance: \$${newBalance.toStringAsFixed(2)}"),
                  ),
                );

                amountController.clear();
              },
              child: Text("Withdraw"),
            ),
            SizedBox(height: 20),
            // Back to Dashboard Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: Text("Back to Dashboard"),
            ),
          ],
        ),
      ),
    );
  }
}
