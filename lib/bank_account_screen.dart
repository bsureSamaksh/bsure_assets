import 'dart:convert';
import 'package:bsure_assets/models/bank_account.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BankAccountsScreen extends StatefulWidget {
  const BankAccountsScreen({super.key});

  @override
  _BankAccountsScreenState createState() => _BankAccountsScreenState();
}

class _BankAccountsScreenState extends State<BankAccountsScreen> {
  List<BankAccount> bankAccounts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchBankAccounts();
  }

  Future<void> fetchBankAccounts() async {
    setState(() {
      isLoading = true;
    });

    final url =
        Uri.parse('https://api.bsure.live/v2/asset/category/BankAccount');
    final response = await http.get(url, headers: {
      "Authorization":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsInVzZXJFbWFpbCI6bnVsbCwidXNlck1vYmlsZSI6IjgzMjg1NjQ2ODMiLCJpYXQiOjE3MTI2ODgwNjIsImV4cCI6MTcxMzI5Mjg2Mn0.i_GsyZhg1GgLkq11q0dGq4cACgb97I_NnC0VWbYY5eg"
    });

    if (response.statusCode == 200) {
      final data = BankResponse.fromJson(jsonDecode(response.body));
      if (data.success) {
        setState(() {
          bankAccounts = data.assets;
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data.message),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch bank accounts'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Accounts'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bankAccounts.isNotEmpty == true
              ? ListView.builder(
                  itemCount: bankAccounts.length,
                  itemBuilder: (context, index) {
                    final account = bankAccounts[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bank Name: ${account.bankName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text('Account Number: ${account.accountNumber}'),
                            const SizedBox(height: 8.0),
                            Text('IFSC Code: ${account.ifscCode}'),
                            const SizedBox(height: 8.0),
                            Text('Branch Name: ${account.branchName}'),
                            const SizedBox(height: 8.0),
                            Text('Account Type: ${account.accountType}'),
                            const SizedBox(height: 8.0),
                            Text('Comments: ${account.comments}'),
                            const SizedBox(height: 8.0),
                            Text('Attachment: ${account.attachment}'),
                            const SizedBox(height: 8.0),
                            Text('Asset ID: ${account.assetId}'),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    'No bank accounts found',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
    );
  }
}
