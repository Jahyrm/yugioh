import 'package:dio/dio.dart';
import 'package:yugioh/core/configs/global_vars.dart';

/// Configuramos dio como cliente http. Como podemos observar, la mayoría de
/// las configuraciones son valores constantes que se encuentran en la clase
/// GlobalVars. En este caso activamos diferentes tiempos de timeout.
final dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: GlobalVars.connectTimeout),
    sendTimeout: const Duration(seconds: GlobalVars.sendTimeout),
    receiveTimeout: const Duration(seconds: GlobalVars.receiveTimeout),
    baseUrl: GlobalVars.apiUrl,
  ),
);
