import 'dart:convert';
import 'package:cryptos/services/http_service.dart';
import 'package:get_it/get_it.dart';

import 'package:cryptos/models/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/HomePage.dart';

void main() async {
  /* assicura che l'app sia iniziallizzata correttamente 
  */
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerHTTPService();
  GetIt.instance.get<HTTPService>().get('/coins/bitcoin');
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  String configContent = await rootBundle.loadString("assets/config/main.json");

  Map configData = jsonDecode(configContent);
  GetIt.instance.registerSingleton<AppConfig>(AppConfig(
    COIN_API_BASE_URL: configData['COIN_API_BASE_URL'],
  ));
}

void registerHTTPService() {
  GetIt.instance.registerSingleton<HTTPService>(HTTPService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color.fromRGBO(88, 60, 197, 1.0)),
      title: "Cryptos",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
