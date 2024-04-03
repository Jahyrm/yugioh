part of 'home_cubit.dart';

final class HomeState extends Equatable {
  const HomeState({
    this.cards,
    this.archetypes,
    this.cardErrorMessage,
    required this.filtering,
    this.selectedArchetype,
    required this.nameFormKey,
    required this.nameTxtController,
    required this.autovalidateName,
    required this.secondFormKey,
    required this.autiovalidateForm,
    required this.selectedCardTypes,
    required this.selectedCardStringTypes,
    required this.selectedRaces,
    this.selectedAttackOperator,
    this.selectedDefenseOperator,
    this.selectedLevelOperator,
    required this.attackTxtController,
    required this.defenseTxtController,
    required this.levelTxtController,
    required this.selectedAttributes,
    required this.selectedStringAttributes,
    required this.loadingHome,
    required this.loadingCards,
    this.errorMessage,
    required this.refresh,
  });

  final List<CardModel>? cards;
  final List<Archetype>? archetypes;
  final String? cardErrorMessage;
  final bool filtering;

  /// Archetype Dropdown
  final Archetype? selectedArchetype;

  /// Fuzzy search by name
  final GlobalKey<FormState> nameFormKey;
  final TextEditingController nameTxtController;
  final bool autovalidateName;

  /// Second form
  final GlobalKey<FormState> secondFormKey;
  final bool autiovalidateForm;

  /// Card Type Dropdown
  final List<CardType> selectedCardTypes;
  final List<String> selectedCardStringTypes;

  /// Race Dropdown
  final List<String> selectedRaces;

  /// Attack Field
  final String? selectedAttackOperator;
  final String? selectedDefenseOperator;
  final String? selectedLevelOperator;
  final TextEditingController attackTxtController;
  final TextEditingController defenseTxtController;
  final TextEditingController levelTxtController;

  /// Attributes Dropdowm
  final List<Attribute> selectedAttributes;
  final List<String> selectedStringAttributes;

  /// Others
  final bool loadingHome;
  final bool loadingCards;
  final String? errorMessage;
  final bool refresh;

  @override
  List<Object?> get props => <Object?>[
        cards,
        archetypes,
        cardErrorMessage,
        filtering,
        selectedArchetype,
        autovalidateName,
        autiovalidateForm,
        selectedCardTypes,
        selectedCardStringTypes,
        selectedRaces,
        selectedAttackOperator,
        selectedDefenseOperator,
        selectedLevelOperator,
        selectedAttributes,
        selectedStringAttributes,
        loadingHome,
        loadingCards,
        errorMessage,
        refresh,
      ];

  HomeState copyWith({
    List<CardModel>? cards,
    List<Archetype>? archetypes,
    String? cardErrorMessage,
    bool? filtering,
    Archetype? selectedArchetype,
    GlobalKey<FormState>? nameFormKey,
    TextEditingController? nameTxtController,
    bool? autovalidateName,
    GlobalKey<FormState>? secondFormKey,
    bool? autiovalidateForm,
    List<CardType>? selectedCardTypes,
    List<String>? selectedCardStringTypes,
    List<String>? selectedRaces,
    String? selectedAttackOperator,
    String? selectedDefenseOperator,
    String? selectedLevelOperator,
    TextEditingController? attackTxtController,
    TextEditingController? defenseTxtController,
    TextEditingController? levelTxtController,
    List<Attribute>? selectedAttributes,
    List<String>? selectedStringAttributes,
    bool? loadingHome,
    bool? loadingCards,
    String? errorMessage,
    bool? refresh,
    bool forceNullSelectedArchetype = false,
    bool forceNullSelectedAttackOperator = false,
    bool forceNullSelectedDefenseOperator = false,
    bool forceNullSelectedLevelOpeerator = false,
    bool forceNullCardErrorMessage = false,
    bool forceNullCards = false,
    bool forceNullErrorMessage = false,
  }) {
    return HomeState(
      cards: cards ?? (forceNullCards ? null : this.cards),
      archetypes: archetypes ?? this.archetypes,
      cardErrorMessage: cardErrorMessage ??
          (forceNullCardErrorMessage ? null : this.cardErrorMessage),
      filtering: filtering ?? this.filtering,
      selectedArchetype: selectedArchetype ??
          (forceNullSelectedArchetype ? null : this.selectedArchetype),
      nameFormKey: nameFormKey ?? this.nameFormKey,
      nameTxtController: nameTxtController ?? this.nameTxtController,
      autovalidateName: autovalidateName ?? this.autovalidateName,
      secondFormKey: secondFormKey ?? this.secondFormKey,
      autiovalidateForm: autiovalidateForm ?? this.autiovalidateForm,
      selectedCardTypes: selectedCardTypes ?? this.selectedCardTypes,
      selectedCardStringTypes:
          selectedCardStringTypes ?? this.selectedCardStringTypes,
      selectedRaces: selectedRaces ?? this.selectedRaces,
      selectedAttackOperator: selectedAttackOperator ??
          (forceNullSelectedAttackOperator
              ? null
              : this.selectedAttackOperator),
      selectedDefenseOperator: selectedDefenseOperator ??
          (forceNullSelectedDefenseOperator
              ? null
              : this.selectedDefenseOperator),
      selectedLevelOperator: selectedLevelOperator ??
          (forceNullSelectedLevelOpeerator ? null : this.selectedLevelOperator),
      attackTxtController: attackTxtController ?? this.attackTxtController,
      defenseTxtController: defenseTxtController ?? this.defenseTxtController,
      levelTxtController: levelTxtController ?? this.levelTxtController,
      selectedAttributes: selectedAttributes ?? this.selectedAttributes,
      selectedStringAttributes:
          selectedStringAttributes ?? this.selectedStringAttributes,
      loadingHome: loadingHome ?? this.loadingHome,
      loadingCards: loadingCards ?? this.loadingCards,
      errorMessage:
          errorMessage ?? (forceNullErrorMessage ? null : this.errorMessage),
      refresh: refresh ?? this.refresh,
    );
  }
}
