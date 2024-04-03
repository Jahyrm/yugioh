import 'package:flutter/material.dart';
import 'package:yugioh/app/card_details/screens/card_details_page.dart';
import 'package:yugioh/app/home/screens/home_page.dart';
import 'package:yugioh/core/models/card.dart';

/// Clase que contiene las rutas de la aplicación.
class AppRouter {
  AppRouter();

  /// Normal routes.
  static final Map<String, Widget Function(BuildContext)> routes = {
    HomePage.routeName: (context) => const HomePage(),
  };

  /// Routes with arguments.
  static Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == CardDetailsPage.routeName) {
      final CardModel card = settings.arguments as CardModel;
      return MaterialPageRoute(
        builder: (context) => CardDetailsPage(card: card),
      );
    }
    assert(false, 'Need to implement ${settings.name}');
    return null;
  }
}
