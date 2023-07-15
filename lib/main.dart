import 'package:flutter/material.dart';

import 'screens/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color.fromRGBO(88, 60, 197, 1.0)),
      title: "Cryptos",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
