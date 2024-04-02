import 'package:dio/dio.dart';
import 'package:yugioh/core/configs/global_vars.dart';

final dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: GlobalVars.connectTimeout),
    sendTimeout: const Duration(seconds: GlobalVars.sendTimeout),
    receiveTimeout: const Duration(seconds: GlobalVars.receiveTimeout),
    baseUrl: GlobalVars.apiUrl,
  ),
);
