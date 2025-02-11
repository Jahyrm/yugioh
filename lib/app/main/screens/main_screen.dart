import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugioh/app/home/screens/home_page.dart';
import 'package:yugioh/core/blocs/app_cubit/app_cubit.dart';
import 'package:yugioh/core/configs/app_themes.dart';
import 'package:yugioh/core/resources/routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (BuildContext context, AppState state) {
        return MaterialApp(
          title: 'Yu-Gi-App!',
          theme: state.darkTheme ? AppThemes.darkTheme : AppThemes.lightTheme,
          routes: AppRouter.routes,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: HomePage.routeName,
        );
      },
    );
  }
}
