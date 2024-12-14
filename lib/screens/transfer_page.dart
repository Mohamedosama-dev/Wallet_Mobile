// screens/transfer_page.dart
import 'package:flutter/material.dart';
import '../services/shared_preferences_service.dart';
import '../models/transaction.dart';

class TransferPage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transfer")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Recipient Phone Number Input
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Recipient Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            // Amount Input
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String recipientPhone = phoneController.text;
                String amountString = amountController.text;
                double? amount = double.tryParse(amountString);

                // Validate input
                if (recipientPhone.isEmpty || amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter valid phone and amount."),
                    ),
                  );
                  return;
                }

                // Get the current balance
                double currentBalance =
                    await sharedPreferencesService.getBalance();

                // Validate sufficient funds
                if (amount > currentBalance) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Insufficient balance.")),
                  );
                  return;
                }

                // Deduct the amount from the balance
                double newBalance = currentBalance - amount;
                await sharedPreferencesService
                    .saveBalance(newBalance); // Save the new balance

                // Save transfer transaction
                Transaction transaction = Transaction(
                  type: "transfer", // Use lowercase for consistency
                  recipient:
                      recipientPhone, // Include recipient phone in transaction
                  amount: amount,
                  date: DateTime.now(), // Pass the current date
                );
                await sharedPreferencesService.saveTransaction(transaction);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Transfer successful to $recipientPhone. New balance: \$${newBalance.toStringAsFixed(2)}"),
                  ),
                );

                // Clear input fields
                phoneController.clear();
                amountController.clear();
              },
              child: Text("Transfer"),
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
