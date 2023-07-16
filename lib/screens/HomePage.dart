import 'dart:convert';

import 'package:cryptos/screens/DetailsPage.dart';
import 'package:cryptos/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? deviceWidth, deviceHeight;
  HTTPService? http;
  String? selectedCoins = 'bitcoin';
  @override
  void initState() {
    super.initState();
    http = GetIt.instance.get<HTTPService>();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              selectedCoinDropdDown(),
              dataWidgetFunction(),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectedCoinDropdDown() {
    List<String> coins = [
      "bitcoin",
      "ethereum",
      "solana",
      "polkadot",
      'dogecoin',
      'ripple',
      'dai',
      'litecoin',
      'chainlink',
      'stellar',
      'okb',
      'cronos',
      'quant',
      'hedera',
    ];

    List<DropdownMenuItem<String>> items = coins
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.toUpperCase(),
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ))
        .toList();
    return DropdownButton<String>(
        underline: Container(),
        value: selectedCoins,
        onChanged: (String? value) {
          setState(() {
            selectedCoins = value;
          });
        },
        items: items,
        dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        iconSize: 30);
  }

  Widget dataWidgetFunction() {
    return FutureBuilder(
      future: http!.get("/coins/${selectedCoins!.toLowerCase()}"),
      builder: (
        BuildContext context,
        AsyncSnapshot snapshot,
      ) {
        if (snapshot.hasData) {
          Map data = jsonDecode(snapshot.data.toString());

          num currentPrice = data['market_data']['current_price']['eur'];
          String description = data['description']["en"].toString();
          num currentPercentage =
              data['market_data']['price_change_percentage_24h'];
          Map exchangeRates = data['market_data']['current_price'];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return DetailsPage(
                      rates: exchangeRates,
                    );
                  }));
                },
                child: coinImageWidget(
                  data['image']['large'],
                ),
              ),
              currentPriceWidget(currentPrice),
              percentageChangeWidget(currentPercentage),
              coinDescriptionWidget(description),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget currentPriceWidget(num rate) {
    return Text(
      "${rate.toStringAsFixed(2)} €",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget percentageChangeWidget(num change) {
    return Text(
      "${change.toStringAsFixed(3)} %",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget coinImageWidget(String imageURL) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: deviceHeight! * 0.02),
      height: deviceHeight! * 0.15,
      width: deviceWidth! * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageURL),
        ),
      ),
    );
  }

  Widget coinDescriptionWidget(String description) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: deviceHeight! * 0.01, horizontal: deviceHeight! * 0.01),
      margin: EdgeInsets.symmetric(vertical: deviceHeight! * 0.05),
      height: deviceHeight! * 0.45,
      width: deviceWidth! * 0.90,
      color: const Color.fromRGBO(83, 88, 206, 1.0),
      child: Text(description, style: const TextStyle(color: Colors.white)),
    );
  }
}
