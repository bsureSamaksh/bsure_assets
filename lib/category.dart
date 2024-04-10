import 'dart:convert';
import 'package:bsure_assets/bank_account_screen.dart';
import 'package:bsure_assets/models/category_response.dart';
import 'package:bsure_assets/mutual_fund_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse('https://api.bsure.live/v2/asset/categories');
    final response = await http.get(url, headers: {
      "Authorization":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsInVzZXJFbWFpbCI6bnVsbCwidXNlck1vYmlsZSI6IjgzMjg1NjQ2ODMiLCJpYXQiOjE3MTI2ODgwNjIsImV4cCI6MTcxMzI5Mjg2Mn0.i_GsyZhg1GgLkq11q0dGq4cACgb97I_NnC0VWbYY5eg"
    });

    if (response.statusCode == 200) {
      final data = CategoryResponse.fromJson(jsonDecode(response.body));
      setState(() {
        categories = data.categories;
      });
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the SecondScreen when the button is pressed
              var widget = category.name == 'MutualFund'
                  ? const MutualFundScreen()
                  : const BankAccountsScreen();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget),
              );
            },
            child: Card(
              elevation: 4.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    category.image,
                    height: 50.0,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    convertPascalCaseToWords(category.name),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

String convertPascalCaseToWords(String input) {
  // Use a regular expression to split the input string into words
  final words = RegExp('[A-Z]?[a-z]+')
      .allMatches(input)
      .map((match) => match.group(0))
      .toList();

  // Join the words with a space in between
  return words.join(' ');
}

/* 
() {
            // Navigate to the SecondScreen when the button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          }
 */