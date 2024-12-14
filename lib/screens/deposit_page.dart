// screens/deposit_page.dart
import 'package:flutter/material.dart';
import '../services/shared_preferences_service.dart';
import '../models/transaction.dart';

class DepositPage extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Deposit")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input for deposit amount
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            // Deposit button
            ElevatedButton(
              onPressed: () async {
                String amountText = amountController.text;
                double? amount = double.tryParse(amountText);

                if (amount != null && amount > 0) {
                  // Get the current balance
                  double currentBalance =
                      await sharedPreferencesService.getBalance();

                  // Update the balance by adding the deposit amount
                  double newBalance = currentBalance + amount;

                  // Save the updated balance
                  await sharedPreferencesService.saveBalance(newBalance);

                  // Save deposit transaction
                  Transaction transaction = Transaction(
                    type: "deposit", // Use lowercase as per your model
                    recipient: "Bank", // Specify the recipient
                    amount: amount,
                    date: DateTime.now(), // Pass the current date
                  );
                  await sharedPreferencesService.saveTransaction(transaction);

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Deposit successful. New balance: \$${newBalance.toStringAsFixed(2)}",
                      ),
                    ),
                  );

                  // Clear the text field
                  amountController.clear();
                } else {
                  // Show error if the input is invalid
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a valid amount")),
                  );
                }
              },
              child: Text("Deposit"),
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
