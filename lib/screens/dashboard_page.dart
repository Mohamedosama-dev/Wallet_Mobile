import 'package:flutter/material.dart';
import '../services/shared_preferences_service.dart';
import 'deposit_page.dart';
import 'withdraw_page.dart';
import 'transfer_page.dart';
import 'recharge_page.dart';
import 'transactions_page.dart';
import 'charity_transfer_page.dart';
import 'pay_bill_page.dart';
import 'home_page.dart'; // Import Home Page for navigation after sign-out

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService(); // Create an instance to access balance and phone credit
  double _balance = 0.0;
  double _phoneCredit = 0.0;

  @override
  void initState() {
    super.initState();
    _loadData(); // Load balance and phone credit when the widget initializes
  }

  // Method to load balance and phone credit
  Future<void> _loadData() async {
    double balance = await sharedPreferencesService.getBalance();
    double phoneCredit = await sharedPreferencesService.getPhoneCredit();
    setState(() {
      _balance = balance;
      _phoneCredit = phoneCredit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          // Sign Out button in AppBar
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Sign out the user
              await sharedPreferencesService.clearUserSession();

              // Navigate to the Home Page or Sign-In Page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false, // Remove all previous routes
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Balance Card at the top of the dashboard
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Current Balance",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "\$${_balance.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Phone Credit Card
            Card(
              elevation: 4.0,
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Phone Credit",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "\$${_phoneCredit.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Dashboard Buttons for each action
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DepositPage()),
                );
                _loadData(); // Refresh balance after deposit
              },
              child: Text("Deposit"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WithdrawPage()),
                );
                _loadData(); // Refresh balance after withdrawal
              },
              child: Text("Withdraw"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransferPage()),
                );
                _loadData(); // Refresh balance after transfer
              },
              child: Text("Transfer"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RechargePage()),
                );
                _loadData(); // Refresh phone credit after recharge
              },
              child: Text("Recharge Phone"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionsPage()),
                );
              },
              child: Text("View Transactions"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CharityTransferPage()),
                );
              },
              child: Text("Transfer to Charity"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PayBillPage()),
                );
              },
              child: Text("Pay Bill"),
            ),
          ],
        ),
      ),
    );
  }
}
