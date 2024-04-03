import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yugioh/core/repositories/card_repository.dart';

part 'card_details_state.dart';

class CardDetailsCubit extends Cubit<CardDetailsState> {
  CardDetailsCubit(this._cardRepository) : super(const CardDetailsState());

  final CardRepository _cardRepository;

  void getOtherNames({required int id}) async {
    emit(state.copyWith(loading: true));
    var frenchResponse =
        await _cardRepository.getCards(id: [id], language: Languages.french);
    var germanResponse =
        await _cardRepository.getCards(id: [id], language: Languages.german);
    emit(state.copyWith(
      loading: false,
      frenchName: frenchResponse.$1?.first.name,
      germanName: germanResponse.$1?.first.name,
    ));
  }
}
