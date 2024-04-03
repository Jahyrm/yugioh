/// Variables globales que se pueden configurar para la app.
class GlobalVars {
  static const String appName = 'Yu-Gi-Oh! Cards App';
  static const String baseUrl = 'https://db.ygoprodeck.com';
  static const String apiUrl = '$baseUrl/api/v7';
  static const bool debugPrints = false;
  static const int connectTimeout = 5; // in seconds
  static const int sendTimeout = 5; // in seconds
  static const int receiveTimeout = 5; // in seconds
}
