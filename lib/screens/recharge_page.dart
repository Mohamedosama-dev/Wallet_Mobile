import 'package:flutter/material.dart';
import '../services/shared_preferences_service.dart';
import '../models/transaction.dart';

class RechargePage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recharge Phone")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Phone number input
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            // Amount input
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String enteredPhone = phoneController.text
                    .trim(); // Trim spaces in the phone number
                String amountString =
                    amountController.text.trim(); // Trim spaces in the amount
                double amount = double.tryParse(amountString) ?? 0.0;

                if (enteredPhone.isEmpty || amount <= 0) {
                  // Show error if input is invalid
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

                // Check for sufficient funds
                if (amount > currentBalance) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Insufficient balance.")),
                  );
                  return;
                }

                // Deduct the amount from the signed-in user's balance
                double newBalance = currentBalance - amount;
                await sharedPreferencesService.saveBalance(newBalance);

                // Add phone credit to the entered phone number (you could extend this logic later)
                // In this case, you could just store the credit in shared preferences
                double currentPhoneCredit =
                    await sharedPreferencesService.getPhoneCredit();
                double newPhoneCredit = currentPhoneCredit + amount;
                await sharedPreferencesService.savePhoneCredit(newPhoneCredit);

                // Create a transaction and save it
                Transaction transaction = Transaction(
                  type: 'Recharge',
                  amount: amount,
                  recipient: enteredPhone, // Store the entered phone number
                  // No need to specify date as it defaults to now
                );
                await sharedPreferencesService.saveTransaction(transaction);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Recharge successful. Phone credit: \$${newPhoneCredit.toStringAsFixed(2)}",
                    ),
                  ),
                );

                // Clear input fields
                phoneController.clear();
                amountController.clear();
              },
              child: Text("Recharge"),
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
