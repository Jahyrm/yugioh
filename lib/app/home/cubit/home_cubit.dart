import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yugioh/core/repositories/card_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._cardRepository) : super(HomeInitial());

  final CardRepository _cardRepository;
}
