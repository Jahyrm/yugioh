import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yugioh/app/main/screens/main_page.dart';
import 'package:yugioh/core/configs/global_vars.dart';
import 'package:yugioh/core/services/yugioh_cards_api.dart';

void main() {
  // We print logs in network calls if is configured to do so (for dev purposes)
  if (GlobalVars.debugPrints) {
    dio.interceptors.add(LogInterceptor());
  }

  // Initilizing the app
  runApp(const MainPage());
}
