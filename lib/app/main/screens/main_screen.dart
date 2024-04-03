import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugioh/app/card_details/screens/card_details_page.dart';
import 'package:yugioh/app/home/screens/home_page.dart';
import 'package:yugioh/core/blocs/app_cubit/app_cubit.dart';
import 'package:yugioh/core/configs/app_themes.dart';
import 'package:yugioh/core/models/card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (BuildContext context, AppState state) {
        return MaterialApp(
          title: 'Yu-Gi-App!',
          theme: state.darkTheme ? AppThemes.darkTheme : AppThemes.lightTheme,
          routes: {
            HomePage.routeName: (context) => const HomePage(),
          },
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name == CardDetailsPage.routeName) {
              final CardModel card = settings.arguments as CardModel;
              return MaterialPageRoute(
                builder: (context) => CardDetailsPage(card: card),
              );
            }
            assert(false, 'Need to implement ${settings.name}');
            return null;
          },
          initialRoute: HomePage.routeName,
        );
      },
    );
  }
}
