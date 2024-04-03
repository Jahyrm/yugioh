import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugioh/app/card_details/cubit/card_details_cubit.dart';
import 'package:yugioh/app/card_details/screens/card_details_screen.dart';
import 'package:yugioh/core/models/card.dart';
import 'package:yugioh/core/repositories/card_repository.dart';

class CardDetailsPage extends StatelessWidget {
  const CardDetailsPage({super.key, required this.card});

  static const String routeName = '/card-details';
  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CardRepository(),
      child: BlocProvider<CardDetailsCubit>(
        create: (context) => CardDetailsCubit(context.read<CardRepository>())
          ..getOtherNames(
            id: card.id!,
          ),
        child: CardDetailsScreen(card: card),
      ),
    );
  }
}
