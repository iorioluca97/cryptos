import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:cryptos/models/app_config.dart';

class HTTPService {
  /*
  Send/Get requests from a http route.
  */
  final Dio dio = Dio();

  AppConfig? appConfig;
  String? baseUrl;
  HTTPService() {
    appConfig = GetIt.instance.get<AppConfig>();
    baseUrl = appConfig!.COIN_API_BASE_URL;
  }

  Future<Response?> get(String path) async {
    try {
      //https://www.coingecko.com/it/api/v3
      String url = '$baseUrl$path';
      Response? response = await dio.get(url);
      return response;
    } catch (e) {
      print("Error, unable to perform the request.");
      print(e);
    }
  }
}
