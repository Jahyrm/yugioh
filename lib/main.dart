import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yugioh/app/main/screens/main_page.dart';
import 'package:yugioh/core/configs/global_vars.dart';
import 'package:yugioh/core/services/yugioh_cards_api.dart';

Future<void> mainApp() async {
  /// Para asegurarnos que todo se inicializa antes de empezar la app
  WidgetsFlutterBinding.ensureInitialized();

  /// Establece la orientación del dispositivo en PorTrait y luego corre la app
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );

  // Imprimimos los logs en las llamadas a la api si está activado en la
  // configuración global (Esto solo debe estar activado en modo debug)
  if (GlobalVars.debugPrints) {
    dio.interceptors.add(LogInterceptor());
  }

  // Inicializamos la app
  runApp(const MainPage());
}
