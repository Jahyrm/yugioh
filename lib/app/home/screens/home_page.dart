import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugioh/app/home/cubit/home_cubit.dart';
import 'package:yugioh/app/home/screens/home_screen.dart';
import 'package:yugioh/core/repositories/card_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    /// Proveemos el repositorio de las cartas para que sea accesible en el bloc
    /// de la pantalla de inicio. Adicionalmente empezamos la obtención de
    /// información de la pantalla de inicio, llamando a la función getHomeInfo.
    return RepositoryProvider(
      create: (context) => CardRepository(),
      child: BlocProvider(
        create: (context) =>
            HomeCubit(context.read<CardRepository>())..getHomeInfo(),
        child: const HomeScreen(),
      ),
    );
  }
}
