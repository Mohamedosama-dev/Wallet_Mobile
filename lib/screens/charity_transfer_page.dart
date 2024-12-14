// screens/charity_transfer_page.dart
import 'package:flutter/material.dart';
import '../services/shared_preferences_service.dart';
import '../models/transaction.dart';

class CharityTransferPage extends StatefulWidget {
  @override
  _CharityTransferPageState createState() => _CharityTransferPageState();
}

class _CharityTransferPageState extends State<CharityTransferPage> {
  final TextEditingController amountController = TextEditingController();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  final List<String> charities = [
    "57357 Hospital",
    "500 500 Hospital",
    "Egyptian Food Bank",
    "Resala Charity Association",
    "Magdy Yaqoub Heart",
    "Orman Association",
    "Bahia Foundation",
    "Mersal Charitable Foundation",
  ];

  String? selectedCharity; // Nullable type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transfer to Charity")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Charity Dropdown Menu
            DropdownButton<String>(
              hint: Text("Select Charity"),
              value: selectedCharity, // This can be null
              onChanged: (String? newValue) {
                setState(() {
                  selectedCharity = newValue; // This can also be null
                });
              },
              items: charities.map<DropdownMenuItem<String>>((String charity) {
                return DropdownMenuItem<String>(
                  value: charity,
                  child: Text(charity),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Amount Input
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String amountString = amountController.text;
                double amount = double.tryParse(amountString) ?? 0.0;

                // Validate input
                if (selectedCharity == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Please select a charity and enter a valid amount."),
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
                await sharedPreferencesService.saveBalance(newBalance);

                // Create a transaction and save it
                Transaction transaction = Transaction(
                  type: "charity",
                  recipient: selectedCharity!,
                  amount: amount,
                );
                await sharedPreferencesService.saveTransaction(transaction);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Donation of \$${amount.toStringAsFixed(2)} to $selectedCharity successful. New balance: \$${newBalance.toStringAsFixed(2)}",
                    ),
                  ),
                );

                // Clear input fields
                amountController.clear();
                setState(() {
                  selectedCharity = null; // Reset charity selection
                });
              },
              child: Text("Donate"),
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
