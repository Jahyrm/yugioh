import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugioh/app/card_details/cubit/card_details_cubit.dart';
import 'package:yugioh/core/blocs/app_cubit/app_cubit.dart';
import 'package:yugioh/core/configs/global_vars.dart';
import 'package:yugioh/core/models/card.dart';
import 'package:yugioh/core/utils/utils.dart';

class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({super.key, required this.card});
  final CardModel card;

  final double imageWidth = 250;
  final double imageHeight = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(GlobalVars.appName),
        actions: [_themeSwitcher()],
      ),
      body: _frame(),
    );
  }

  BlocBuilder _themeSwitcher() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (BuildContext context, AppState state) {
        return IconButton(
          onPressed: context.read<AppCubit>().toggleTheme,
          icon: Icon(state.darkTheme ? Icons.light_mode : Icons.dark_mode),
        );
      },
    );
  }

  Widget _frame() {
    return Column(
      children: [
        _verticalSide(Utils.getBackgroundCardColors(card).$1),
        Expanded(
          child: SizedBox(
            height: double.infinity,
            child: Row(
              children: [
                _horizontalSide(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: _body(),
                    ),
                  ),
                ),
                _horizontalSide(),
              ],
            ),
          ),
        ),
        _verticalSide(Utils.getBackgroundCardColors(card).$2),
      ],
    );
  }

  BlocBuilder<AppCubit, AppState> _verticalSide(Color color) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          height: 28,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                color,
                color,
                context.watch<AppCubit>().state.darkTheme
                    ? Colors.black
                    : Colors.white,
                color,
                color,
              ],
            ),
          ),
        );
      },
    );
  }

  BlocBuilder<AppCubit, AppState> _horizontalSide() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          width: 28,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Utils.getBackgroundCardColors(card).$1,
                Utils.getBackgroundCardColors(card).$1,
                Utils.getBackgroundCardColors(card).$1.withOpacity(0.85),
                Utils.getBackgroundCardColors(card).$2.withOpacity(0.85),
                Utils.getBackgroundCardColors(card).$2,
                Utils.getBackgroundCardColors(card).$2,
              ],
            ),
          ),
        );
      },
    );
  }

  BlocBuilder<CardDetailsCubit, CardDetailsState> _body() {
    return BlocBuilder<CardDetailsCubit, CardDetailsState>(
      builder: (BuildContext context, CardDetailsState state) {
        if (state.loading) {
          return _loading();
        }
        return Column(
          children: [
            _cardImages(),
            const Divider(),
            const SizedBox(height: 2),
            _name(),
            if (state.frenchName?.isNotEmpty ?? false)
              const SizedBox(height: 2),
            if (state.frenchName?.isNotEmpty ?? false) _frenchName(),
            if (state.germanName?.isNotEmpty ?? false)
              const SizedBox(height: 2),
            if (state.germanName?.isNotEmpty ?? false) _germanName(),
            const SizedBox(height: 2),
            _card(),
            if (card.attribute != null) const SizedBox(height: 2),
            if (card.attribute != null) _attribute(),
            if (card.linkval != null) const SizedBox(height: 2),
            if (card.linkval != null) _link(),
            if (card.race != null) const SizedBox(height: 2),
            if (card.race != null) _race(),
            if (card.level != null) const SizedBox(height: 2),
            if (card.level != null) _level(),
            if (card.atk != null) const SizedBox(height: 2),
            if (card.atk != null) _attack(),
            if (card.def != null) const SizedBox(height: 2),
            if (card.def != null) _defense(),
          ],
        );
      },
    );
  }

  Widget _loading() {
    return const Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 8),
        Text('Loading...'),
      ],
    ));
  }

  Widget _cardImages() {
    return SizedBox(
      width: imageWidth,
      height: imageHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: card.cardImages?.first.imageUrlCropped ?? '',
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Center(
                    child: Column(
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(height: 8),
                    Text('API query limit reached.')
                  ],
                )),
                width: imageWidth - 25,
                height: imageHeight - 25,
                fit: BoxFit.fill,
              ),
            ),
          ),
          if (card.type == 'Link Monster' && card.linkmarkers != null)
            _linkMarkers(),
        ],
      ),
    );
  }

  SizedBox _linkMarkers() {
    return SizedBox(
      width: imageWidth,
      height: imageHeight,
      child: Stack(
        children: [
          if (card.linkmarkers!.contains(LinkMarker.topLetf))
            Image.asset(
              'assets/images/linkarrows/Top-Left.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            )
          else
            Image.asset(
              'assets/images/linkarrows/Top-Left-Off.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            ),
          if (card.linkmarkers!.contains(LinkMarker.top))
            Image.asset(
              'assets/images/linkarrows/Top.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            )
          else
            Image.asset(
              'assets/images/linkarrows/Top-Off.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            ),
          if (card.linkmarkers!.contains(LinkMarker.topRight))
            Image.asset(
              'assets/images/linkarrows/Top-Right.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            )
          else
            Image.asset(
              'assets/images/linkarrows/Top-Right-Off.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            ),
          if (card.linkmarkers!.contains(LinkMarker.left))
            Image.asset(
              'assets/images/linkarrows/Left.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            )
          else
            Image.asset(
              'assets/images/linkarrows/Left-Off.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            ),
          if (card.linkmarkers!.contains(LinkMarker.right))
            Image.asset(
              'assets/images/linkarrows/Right.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            )
          else
            Image.asset(
              'assets/images/linkarrows/Right-Off.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            ),
          if (card.linkmarkers!.contains(LinkMarker.bottomLeft))
            Image.asset(
              'assets/images/linkarrows/Bottom-Left.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            )
          else
            Image.asset(
              'assets/images/linkarrows/Bottom-Left-Off.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            ),
          if (card.linkmarkers!.contains(LinkMarker.bottom))
            Image.asset(
              'assets/images/linkarrows/Bottom.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            )
          else
            Image.asset(
              'assets/images/linkarrows/Bottom-Off.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            ),
          if (card.linkmarkers!.contains(LinkMarker.bottomRight))
            Image.asset(
              'assets/images/linkarrows/Bottom-Right.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            )
          else
            Image.asset(
              'assets/images/linkarrows/Bottom-Right-Off.png',
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.fill,
            ),
        ],
      ),
    );
  }

  Card _name() {
    return Card(
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: const Text(
          'Name',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(card.name ?? ''),
      ),
    );
  }

  BlocBuilder<CardDetailsCubit, CardDetailsState> _frenchName() {
    return BlocBuilder<CardDetailsCubit, CardDetailsState>(
      builder: (context, state) {
        return Card(
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: const Text(
              'French Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(state.frenchName!),
          ),
        );
      },
    );
  }

  BlocBuilder<CardDetailsCubit, CardDetailsState> _germanName() {
    return BlocBuilder<CardDetailsCubit, CardDetailsState>(
      builder: (context, state) {
        return Card(
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: const Text(
              'German Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(state.germanName!),
          ),
        );
      },
    );
  }

  Card _card() {
    return Card(
      child: ListTile(
        dense: true,
        title: const Text(
          'Card',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/${card.type}.jpg',
                width: 25, height: 25),
            const SizedBox(width: 8),
            Text(card.type ?? ''),
          ],
        ),
      ),
    );
  }

  Card _attribute() {
    return Card(
      child: ListTile(
        dense: true,
        title: const Text(
          'Attribute',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
                'assets/images/attributes/${card.attribute!.name.toUpperCase()}.png',
                width: 25,
                height: 25),
            const SizedBox(width: 8),
            Text(card.attribute?.name.toUpperCase() ?? ''),
          ],
        ),
      ),
    );
  }

  Card _link() {
    return Card(
      child: ListTile(
        dense: true,
        title: const Text(
          'Link',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(card.linkval?.toString() ?? ''),
      ),
    );
  }

  Card _race() {
    return Card(
      child: ListTile(
        dense: true,
        title: const Text(
          'Type',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/race/${card.race}.png',
                width: 25, height: 25),
            const SizedBox(width: 8),
            Text(card.race ?? ''),
          ],
        ),
      ),
    );
  }

  Card _level() {
    return Card(
      child: ListTile(
        dense: true,
        title: Text(
          card.type == 'XYZ Monster' ||
                  card.type == 'XYZ Pendulum Effect Monster'
              ? 'Rank'
              : 'Level',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (int i = 0; i < card.level!; i++)
              Image.asset(
                  'assets/images/levels/${card.type == 'XYZ Monster' || card.type == 'XYZ Pendulum Effect Monster' ? 'rank' : 'level'}.png',
                  width: 25,
                  height: 25),
            const SizedBox(width: 8),
            Text('(${card.level})'),
          ],
        ),
      ),
    );
  }

  Card _attack() {
    return Card(
      child: ListTile(
        dense: true,
        title: const Text(
          'Attack',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.bolt),
            const SizedBox(width: 8),
            Text(card.atk!.toString()),
          ],
        ),
      ),
    );
  }

  Card _defense() {
    return Card(
      child: ListTile(
        dense: true,
        title: const Text(
          'Defense',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.shield, weight: 25),
            const SizedBox(width: 8),
            Text(card.def!.toString()),
          ],
        ),
      ),
    );
  }
}
