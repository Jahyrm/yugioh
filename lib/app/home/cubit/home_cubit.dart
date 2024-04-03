import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:yugioh/app/home/widgets/form.dart';
import 'package:yugioh/core/models/archetype.dart';
import 'package:yugioh/core/models/card.dart';
import 'package:yugioh/core/repositories/card_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  /// Este Cubit requiere del repositorio de cartas, ademas le asignamos el
  /// estado inicial con el que empieza la app.
  HomeCubit(this._cardRepository)
      : super(
          HomeState(
            filtering: false,
            nameFormKey: GlobalKey<FormState>(),
            nameTxtController: TextEditingController(),
            autovalidateName: false,
            secondFormKey: GlobalKey<FormState>(),
            autiovalidateForm: false,
            selectedCardTypes: const [],
            selectedCardStringTypes: const [],
            selectedRaces: const [],
            attackTxtController: TextEditingController(),
            defenseTxtController: TextEditingController(),
            levelTxtController: TextEditingController(),
            selectedAttributes: const [],
            selectedStringAttributes: const [],
            loadingCards: false,
            loadingHome: true,
            refresh: false,
          ),
        );

  final CardRepository _cardRepository;

  /// Método que obtiene la información que se muestra en la pantalla de inicio.
  void getHomeInfo() async {
    try {
      var archsResponse = await _cardRepository.getArchetypes();
      if (archsResponse.$2 != null) {
        emit(state.copyWith(
          loadingHome: false,
          errorMessage: archsResponse.$2!,
        ));
        return;
      }
      var cardsResponse = await _cardRepository.getCards();
      emit(
        state.copyWith(
          cards: cardsResponse.$1,
          archetypes: archsResponse.$1!,
          cardErrorMessage: cardsResponse.$2,
          filtering: false,
          loadingHome: false,
          forceNullErrorMessage: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        loadingHome: false,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Método que actualiza la lista de cartas dependiendo de los parámentros de
  /// búsqueda.
  void getCards({
    String? fname,
    List<CardType>? types,
    String? atk,
    String? def,
    String? level,
    List<String>? races,
    List<Attribute>? attributes,
    Archetype? archetype,
    bool hideFilter = false,
  }) async {
    try {
      emit(
        state.copyWith(
          loadingCards: true,
          cards: null,
          cardErrorMessage: null,
          forceNullCards: true,
          forceNullCardErrorMessage: true,
          filtering: hideFilter ? false : state.filtering,
        ),
      );
      var cardsResponse = await _cardRepository.getCards(
        fname: fname,
        type: types,
        atk: atk,
        def: def,
        level: level,
        race: races,
        attribute: attributes,
        archetype: archetype,
      );
      emit(
        state.copyWith(
          cards: cardsResponse.$1,
          cardErrorMessage: cardsResponse.$2,
          loadingCards: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        loadingCards: false,
        cardErrorMessage: e.toString(),
      ));
    }
  }

  /* Los siguientes son métodos que nos permiten interactuar con el estado */

  void setFiltering(bool bool) {
    emit(state.copyWith(filtering: bool));
  }

  void setArchetype(Archetype? archetype) {
    emit(
      state.copyWith(
        selectedArchetype: archetype,
        forceNullSelectedArchetype: true,
      ),
    );
  }

  void setAutovalidateName(bool bool) {
    emit(state.copyWith(autovalidateName: bool));
  }

  void refresh() {
    emit(state.copyWith(refresh: !state.refresh));
  }

  void setOperator(FieldType type, String? operator) {
    switch (type) {
      case FieldType.attack:
        emit(state.copyWith(
          selectedAttackOperator: operator,
          forceNullSelectedAttackOperator: true,
        ));
        break;
      case FieldType.defense:
        emit(state.copyWith(
          selectedDefenseOperator: operator,
          forceNullSelectedDefenseOperator: true,
        ));
        break;
      case FieldType.level:
        emit(state.copyWith(
          selectedLevelOperator: operator,
          forceNullSelectedLevelOpeerator: true,
        ));
        break;
    }
  }

  void setAutovalidateForm(bool bool) {
    emit(state.copyWith(autiovalidateForm: bool));
  }

  void removeCardType(CardType type) {
    emit(state.copyWith(
      selectedCardTypes: List.from(state.selectedCardTypes)..remove(type),
      selectedCardStringTypes: List.from(state.selectedCardStringTypes)
        ..remove(
            '${type.name[0].toUpperCase()}${type.name.substring(1)} Cards'),
      selectedRaces: [],
    ));
  }

  void addCardType(CardType type) {
    emit(
      state.copyWith(
        selectedCardTypes: List.from(state.selectedCardTypes)..add(type),
        selectedCardStringTypes: List.from(state.selectedCardStringTypes)
          ..add('${type.name[0].toUpperCase()}${type.name.substring(1)} Cards'),
        selectedRaces: [],
      ),
    );
  }

  void removeRace(String race) {
    emit(
      state.copyWith(
        selectedRaces: List.from(state.selectedRaces)..remove(race),
      ),
    );
  }

  void addRace(String race) {
    emit(
      state.copyWith(
        selectedRaces: List.from(state.selectedRaces)..add(race),
      ),
    );
  }

  void removeAttribute(Attribute attr) {
    emit(state.copyWith(
      selectedAttributes: List.from(state.selectedAttributes)..remove(attr),
      selectedStringAttributes: List.from(state.selectedStringAttributes)
        ..remove('${attr.name[0].toUpperCase()}${attr.name.substring(1)}'),
    ));
  }

  void addAttribute(Attribute attr) {
    emit(state.copyWith(
      selectedAttributes: List.from(state.selectedAttributes)..add(attr),
      selectedStringAttributes: List.from(state.selectedStringAttributes)
        ..add('${attr.name[0].toUpperCase()}${attr.name.substring(1)}'),
    ));
  }
}
