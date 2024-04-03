import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugioh/app/home/cubit/home_cubit.dart';
import 'package:yugioh/app/home/widgets/card_item_widget.dart';
import 'package:yugioh/app/home/widgets/form.dart';
import 'package:yugioh/core/blocs/app_cubit/app_cubit.dart';
import 'package:yugioh/core/configs/global_vars.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(GlobalVars.appName),
        actions: [_themeSwitcher(context)],
      ),
      body: _body(context),
    );
  }

  BlocBuilder _themeSwitcher(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (BuildContext context, AppState state) {
        return IconButton(
          onPressed: context.read<AppCubit>().toggleTheme,
          icon: Icon(state.darkTheme ? Icons.light_mode : Icons.dark_mode),
        );
      },
    );
  }

  void _listener(BuildContext context, HomeState state) {
    // Show error message to the user.
    if (state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage!)),
      );
    }
  }

  BlocConsumer _body(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: _listener,
      builder: (BuildContext context, HomeState state) {
        if (state.loadingHome) {
          return _loading();
        } else {
          if (state.errorMessage != null) {
            return _error(context, state.errorMessage);
          }
          Widget child = Column(
            children: [
              Container(
                color: context.watch<AppCubit>().state.darkTheme
                    ? Colors.grey[800]
                    : Colors.grey[200],
                child: const HomeForm(horizontalPadding: 8, verticalPadding: 8),
              ),
              if (!state.filtering)
                Expanded(
                  flex: 3,
                  child: _cardsList(),
                ),
            ],
          );
          if (state.filtering) {
            return SingleChildScrollView(child: child);
          } else {
            return child;
          }
        }
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

  Widget _cardsList() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        if (state.cards == null || state.cardErrorMessage != null) {
          return _error(context, state.cardErrorMessage);
        }
        if (state.cards!.isEmpty) {
          return _empty();
        }
        return ListView.separated(
          itemCount: state.cards!.length,
          itemBuilder: (BuildContext context, int index) {
            return CardItem(card: state.cards![index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        );
      },
    );
  }

  Center _error(BuildContext context, String? cardErrorMessage) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Error',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(cardErrorMessage ?? 'No cards found.'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: context.read<HomeCubit>().getHomeInfo,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  Center _empty() {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
        child: const Text('No cards found.', textAlign: TextAlign.center),
      ),
    );
  }
}
