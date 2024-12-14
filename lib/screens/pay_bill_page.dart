// screens/pay_bill_page.dart
import 'package:flutter/material.dart';
import '../services/shared_preferences_service.dart';
import '../models/transaction.dart'; // Ensure this is imported

class PayBillPage extends StatefulWidget {
  @override
  _PayBillPageState createState() => _PayBillPageState();
}

class _PayBillPageState extends State<PayBillPage> {
  final TextEditingController serviceNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  final List<String> services = [
    "Internet",
    "Water",
    "Gas",
    "Electricity",
  ];

  String? selectedService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pay Service Bill")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Service Dropdown Menu
            DropdownButton<String>(
              hint: Text("Select Service"),
              value: selectedService,
              onChanged: (String? newValue) {
                setState(() {
                  selectedService = newValue;
                });
              },
              items: services.map<DropdownMenuItem<String>>((String service) {
                return DropdownMenuItem<String>(
                  value: service,
                  child: Text(service),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Service Number Input
            TextField(
              controller: serviceNumberController,
              decoration: InputDecoration(labelText: "Service Number"),
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
                String serviceNumber = serviceNumberController.text;
                String amountString = amountController.text;
                double amount = double.tryParse(amountString) ?? 0.0;

                // Validate input
                if (selectedService == null ||
                    serviceNumber.isEmpty ||
                    amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Please select a service, enter a service number, and a valid amount."),
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

                // Create a transaction
                Transaction transaction = Transaction(
                  type: "bill_payment",
                  recipient:
                      selectedService!, // Using service type as recipient
                  amount: amount,
                );

                // Save the transaction
                await sharedPreferencesService.saveTransaction(transaction);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Payment of \$${amount.toStringAsFixed(2)} for $selectedService successful. New balance: \$${newBalance.toStringAsFixed(2)}",
                    ),
                  ),
                );

                // Clear input fields
                serviceNumberController.clear();
                amountController.clear();
                setState(() {
                  selectedService = null; // Reset service selection
                });
              },
              child: Text("Pay Bill"),
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
