import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugioh/app/main/screens/main_screen.dart';
import 'package:yugioh/core/blocs/app_cubit/app_cubit.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Proveemos el cubit (bloc) de la app para que sea accesible
    /// en toda la app, para este ejemplo este bloc solo permite cambiar el tema
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit(),
      child: const MainScreen(),
    );
  }
}
