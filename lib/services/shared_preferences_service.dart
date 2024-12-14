import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/transaction.dart';

class SharedPreferencesService {
  // Keys for balance, transactions, phone credit, and signed-in phone
  static const String balanceKey = 'balance';
  static const String transactionsKey = 'transactions';
  static const String phoneCreditKey = 'phone_credit';
  static const String signedInPhoneKey = 'signed_in_phone';

  // Save a user to SharedPreferences
  Future<void> saveUser(User user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userJson = jsonEncode(user.toJson());
      await prefs.setString(
          user.phone, userJson); // Store the user as a JSON string
    } catch (e) {
      // Handle errors, if any
      print("Error saving user: $e");
    }
  }

  // Get a user by phone number
  Future<User?> getUser(String phone) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userData = prefs.getString(phone);
      if (userData != null) {
        Map<String, dynamic> userMap = jsonDecode(userData);
        return User.fromJson(userMap);
      }
    } catch (e) {
      // Handle errors, if any
      print("Error fetching user: $e");
    }
    return null; // Return null if user not found or an error occurred
  }

  // Save the balance to SharedPreferences
  Future<void> saveBalance(double balance) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(balanceKey, balance);
    } catch (e) {
      print("Error saving balance: $e");
    }
  }

  // Retrieve the balance from SharedPreferences
  Future<double> getBalance() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(balanceKey) ??
          0.0; // Return 0.0 if balance is not set
    } catch (e) {
      print("Error fetching balance: $e");
      return 0.0; // Return 0.0 if an error occurs
    }
  }

  // Save phone credit to SharedPreferences
  Future<void> savePhoneCredit(double credit) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(phoneCreditKey, credit);
    } catch (e) {
      print("Error saving phone credit: $e");
    }
  }

  // Retrieve phone credit from SharedPreferences
  Future<double> getPhoneCredit() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(phoneCreditKey) ??
          0.0; // Return 0.0 if phone credit is not set
    } catch (e) {
      print("Error fetching phone credit: $e");
      return 0.0; // Return 0.0 if an error occurs
    }
  }

  // Save the signed-in phone number to SharedPreferences
  Future<void> savePhoneNumber(String phone) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(signedInPhoneKey, phone);
    } catch (e) {
      print("Error saving signed-in phone: $e");
    }
  }

  // Retrieve the signed-in phone number from SharedPreferences
  Future<String?> getPhoneNumber() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(signedInPhoneKey); // Return phone number if found
    } catch (e) {
      print("Error fetching signed-in phone: $e");
      return null; // Return null if an error occurs
    }
  }

  // Save a transaction to SharedPreferences
  Future<void> saveTransaction(Transaction transaction) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> transactions = prefs.getStringList(transactionsKey) ?? [];
      transactions.add(jsonEncode(transaction.toJson()));
      await prefs.setStringList(transactionsKey, transactions);
    } catch (e) {
      print("Error saving transaction: $e");
    }
  }

  // Retrieve all transactions from SharedPreferences
  Future<List<Transaction>> getTransactions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> transactions = prefs.getStringList(transactionsKey) ?? [];
      return transactions
          .map((json) => Transaction.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      print("Error fetching transactions: $e");
      return [];
    }
  }

  // Retrieve transactions with optional filtering (e.g., by type)
  Future<List<Transaction>> getTransactionsByType(String type) async {
    try {
      List<Transaction> allTransactions = await getTransactions();
      return allTransactions.where((t) => t.type == type).toList();
    } catch (e) {
      print("Error filtering transactions: $e");
      return [];
    }
  }

  // Clear all data from SharedPreferences (for sign-out or reset purposes)
  Future<void> clearAllData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print("Error clearing data: $e");
    }
  }

  // Clear user session (just for sign out, not clearing all data)
  Future<void> clearUserSession() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs
          .remove(signedInPhoneKey); // Only remove the signed-in phone key
    } catch (e) {
      print("Error clearing user session: $e");
    }
  }
}
