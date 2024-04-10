import 'dart:convert';
import 'package:bsure_assets/models/stock_broker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StockBrokerScreen extends StatefulWidget {
  const StockBrokerScreen({super.key});

  @override
  _StockBrokerScreenState createState() => _StockBrokerScreenState();
}

class _StockBrokerScreenState extends State<StockBrokerScreen> {
  List<StockBroker> stockBrokers = [];
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
        Uri.parse('https://api.bsure.live/v2/asset/category/StockBroker');
    final response = await http.get(url, headers: {
      "Authorization":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsInVzZXJFbWFpbCI6bnVsbCwidXNlck1vYmlsZSI6IjgzMjg1NjQ2ODMiLCJpYXQiOjE3MTI2ODgwNjIsImV4cCI6MTcxMzI5Mjg2Mn0.i_GsyZhg1GgLkq11q0dGq4cACgb97I_NnC0VWbYY5eg"
    });

    if (response.statusCode == 200) {
      final data = StockBrokerResponse.fromJson(jsonDecode(response.body));
      if (data.success) {
        setState(() {
          stockBrokers = data.assets;
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
        title: const Text('Mutual Funds'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : stockBrokers.isNotEmpty == true
              ? ListView.builder(
                  itemCount: stockBrokers.length,
                  itemBuilder: (context, index) {
                    final fund = stockBrokers[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AMC Name: ${fund.amcName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text('Scheme Name: ${fund.schemeName}'),
                            const SizedBox(height: 8.0),
                            Text('Folio Number: ${fund.folioNumber}'),
                            const SizedBox(height: 8.0),
                            Text('Fund Type: ${fund.fundType}'),
                            const SizedBox(height: 8.0),
                            Text('Comments: ${fund.comments}'),
                            const SizedBox(height: 8.0),
                            Text('Attachment: ${fund.attachment}'),
                            const SizedBox(height: 8.0),
                            Text('Asset ID: ${fund.assetId}'),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    'No mutual funds found',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
    );
  }
}
