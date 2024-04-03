import 'package:flutter/material.dart';
import 'package:yugioh/app/card_details/screens/card_details_screen.dart';
import 'package:yugioh/core/models/card.dart';
import 'package:yugioh/core/utils/utils.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            colors: [
              Utils.getBackgroundCardColors(card).$1,
              Utils.getBackgroundCardColors(card).$1,
              // Colors.grey[200]!,
              Utils.getBackgroundCardColors(card).$1.withOpacity(0.85),
              Utils.getBackgroundCardColors(card).$2,
              Utils.getBackgroundCardColors(card).$2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              CardDetailsScreen.routeName,
              arguments: card,
            );
          },
          leading: Image.asset('assets/images/${card.type}.jpg'),
          title: Text(card.name ?? ''),
          subtitle: Text(card.type ?? ''),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('See Details'),
              SizedBox(width: 2),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
