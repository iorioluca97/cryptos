import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({required this.rates, Key? key}) : super(key: key);

  final Map rates;

  @override
  Widget build(BuildContext context) {
    List currencies = rates.keys.toList();
    List exchangeRates = rates.values.toList();
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemCount: currencies.length,
        itemBuilder: (context, index) {
          String currency = currencies[index].toUpperCase();
          String rate = exchangeRates[index].toString();
          return ListTile(
            title: Text('$currency : $rate',
                style: TextStyle(color: Colors.white)),
          );
        },
      )),
    );
  }
}
