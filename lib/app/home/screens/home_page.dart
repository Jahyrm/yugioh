import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugioh/app/home/cubit/home_cubit.dart';
import 'package:yugioh/app/home/screens/home_screen.dart';
import 'package:yugioh/core/repositories/card_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
