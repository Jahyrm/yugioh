import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugioh/app/home/cubit/home_cubit.dart';
import 'package:yugioh/core/models/archetype.dart';
import 'package:yugioh/core/models/card.dart';
import 'package:yugioh/core/repositories/card_repository.dart';
import 'package:yugioh/core/utils/utils.dart';
import 'package:yugioh/core/widgets/icon_button.dart';

enum FieldType { attack, defense, level }

class HomeForm extends StatefulWidget {
  const HomeForm({
    super.key,
    required this.horizontalPadding,
    this.verticalPadding,
  });

  final double? horizontalPadding;
  final double? verticalPadding;

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding ?? 0,
            vertical: widget.verticalPadding ?? 0,
          ),
          child: Column(
            children: [
              _archetypeDropdown(),
              _searchByNameField(),
              if (state.filtering) ...[
                _cardTypeDropdown(),
                Form(
                  key: state.secondFormKey,
                  autovalidateMode: state.autiovalidateForm
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      if (state.selectedCardTypes.contains(CardType.monster) ||
                          state.selectedCardTypes.contains(CardType.spell) ||
                          state.selectedCardTypes.contains(CardType.trap))
                        _raceDropDown(),
                      if (state.selectedCardTypes
                          .contains(CardType.monster)) ...[
                        _filterAmountField(FieldType.attack),
                        _filterAmountField(FieldType.defense),
                        _filterAmountField(FieldType.level),
                        _attributesDropDown(),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buttons(),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _archetypeDropdown() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return DropdownButtonFormField<Archetype>(
          value: state.selectedArchetype,
          onChanged: (value) {
            context.read<HomeCubit>().setArchetype(value);
          },
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('All Archetypes'),
            ),
            ...state.archetypes
                    ?.map(
                      (archetype) => DropdownMenuItem(
                        value: archetype,
                        child: Text(archetype.name ?? 'Unknown'),
                      ),
                    )
                    .toList() ??
                []
          ],
          decoration: const InputDecoration(
            labelText: 'Select an archetype',
          ),
        );
      },
    );
  }

  Widget _searchByNameField() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Form(
          key: state.nameFormKey,
          autovalidateMode: state.autovalidateName
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: state.nameTxtController,
                  decoration: const InputDecoration(
                    labelText: 'Search by name',
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty ?? false) {
                      return null;
                    }
                    return 'Please enter a name.';
                  },
                ),
              ),
              const SizedBox(width: 8),
              AppIconButton(
                onPressed: () {
                  if (state.nameFormKey.currentState?.validate() ?? false) {
                    context.read<HomeCubit>().setAutovalidateName(false);
                    Utils.hideKeyboard();
                    context.read<HomeCubit>().getCards(
                          fname: state.nameTxtController.text,
                          archetype: state.selectedArchetype,
                        );
                  } else {
                    context.read<HomeCubit>().setAutovalidateName(false);
                  }
                },
                icon: const Icon(Icons.search),
              ),
              const SizedBox(width: 8),
              AppIconButton(
                onPressed: () {
                  if (state.filtering) {
                    context.read<HomeCubit>().setFiltering(false);
                  } else {
                    context.read<HomeCubit>().setFiltering(true);
                  }
                },
                icon: const Icon(Icons.filter_list_rounded),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _cardTypeDropdown() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (nContext, state) {
        return DropdownButtonFormField2(
          decoration: const InputDecoration(labelText: 'Select the card types'),
          alignment: AlignmentDirectional.centerStart,
          isExpanded: true,
          hint: const Text('All Types'),
          items: CardType.values
              .map(
                (type) => DropdownMenuItem(
                  enabled: false,
                  value: type,
                  child: BlocBuilder<HomeCubit, HomeState>(
                      bloc: nContext.read<HomeCubit>(),
                      builder: (BuildContext context, HomeState state) {
                        final isSelected =
                            state.selectedCardTypes.contains(type);
                        return InkWell(
                          onTap: () {
                            if (isSelected) {
                              nContext.read<HomeCubit>().removeCardType(type);
                            } else {
                              nContext.read<HomeCubit>().addCardType(type);
                            }
                          },
                          child: Container(
                            height: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                if (isSelected)
                                  const Icon(Icons.check_box_outlined)
                                else
                                  const Icon(Icons.check_box_outline_blank),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    '${type.name[0].toUpperCase()}${type.name.substring(1)} Cards',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
              .toList(),
          value: state.selectedCardTypes.isEmpty
              ? null
              : state.selectedCardTypes.last,
          onChanged: (value) {},
          menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.zero),
          selectedItemBuilder: (context) {
            return CardType.values.map(
              (type) {
                return Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    state.selectedCardStringTypes.join(', '),
                    textAlign: TextAlign.left,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                );
              },
            ).toList();
          },
        );
      },
    );
  }

  Widget _raceDropDown() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (nContext, homeState) {
        Set<String> finalRaces = {};
        if (homeState.selectedCardTypes.contains(CardType.monster)) {
          finalRaces.addAll(CardRepository.monsterRaces);
        }
        if (homeState.selectedCardTypes.contains(CardType.spell)) {
          finalRaces.addAll(CardRepository.spellRaces);
        }
        if (homeState.selectedCardTypes.contains(CardType.trap)) {
          finalRaces.addAll(CardRepository.trapRaces);
        }
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return DropdownButtonFormField2(
              decoration: const InputDecoration(labelText: 'Select races'),
              alignment: AlignmentDirectional.centerStart,
              isExpanded: true,
              hint: const Text('All races'),
              items: finalRaces
                  .map(
                    (race) => DropdownMenuItem(
                      enabled: false,
                      value: race,
                      child: BlocBuilder<HomeCubit, HomeState>(
                          bloc: nContext.read<HomeCubit>(),
                          builder: (
                            BuildContext context,
                            HomeState state,
                          ) {
                            final isSelected =
                                state.selectedRaces.contains(race);
                            return InkWell(
                              onTap: () {
                                if (isSelected) {
                                  nContext.read<HomeCubit>().removeRace(race);
                                } else {
                                  nContext.read<HomeCubit>().addRace(race);
                                }
                              },
                              child: Container(
                                height: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    if (isSelected)
                                      const Icon(Icons.check_box_outlined)
                                    else
                                      const Icon(Icons.check_box_outline_blank),
                                    const SizedBox(width: 16),
                                    Expanded(child: Text(race)),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                  .toList(),
              value: homeState.selectedRaces.isEmpty
                  ? null
                  : homeState.selectedRaces.last,
              onChanged: (value) {},
              menuItemStyleData:
                  const MenuItemStyleData(padding: EdgeInsets.zero),
              selectedItemBuilder: (context) {
                return finalRaces.map(
                  (race) {
                    return Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        homeState.selectedRaces.join(', '),
                        textAlign: TextAlign.left,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      ),
                    );
                  },
                ).toList();
              },
            );
          },
        );
      },
    );
  }

  BlocBuilder<HomeCubit, HomeState> _filterAmountField(FieldType fieldType) {
    String stringTitle =
        '${fieldType.name[0].toUpperCase()}${fieldType.name.substring(1)}';
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: 60,
              child: Text(stringTitle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String?>(
                value: fieldType == FieldType.attack
                    ? state.selectedAttackOperator
                    : fieldType == FieldType.defense
                        ? state.selectedDefenseOperator
                        : state.selectedLevelOperator,
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('Equals to'),
                  ),
                  ...[
                    'lt:Less than',
                    'lte:Equal or less than',
                    'gt:Greater than',
                    'gte:Equal or greater than'
                  ].map(
                    (String value) {
                      List<String> vector = value.split(':');
                      return DropdownMenuItem<String>(
                        value: vector[0],
                        child: Text(vector[1]),
                      );
                    },
                  ).toList()
                ],
                onChanged: (String? operator) {
                  context.read<HomeCubit>().setOperator(fieldType, operator);
                },
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: fieldType == FieldType.attack
                    ? state.attackTxtController
                    : fieldType == FieldType.defense
                        ? state.defenseTxtController
                        : state.levelTxtController,
                decoration: const InputDecoration(counterText: ''),
                maxLength: fieldType == FieldType.level ? 2 : 4,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return null;
                  } else {
                    if (int.tryParse(value!) == null) {
                      return 'Only numbers.';
                    }
                    switch (fieldType) {
                      case FieldType.attack:
                        if (int.parse(value) < 0 || int.parse(value) > 5000) {
                          return 'range: 1-5000.';
                        }
                        break;
                      case FieldType.defense:
                        if (int.parse(value) < 0 || int.parse(value) > 5000) {
                          return 'range: 1-5000.';
                        }
                        break;
                      case FieldType.level:
                        if (int.parse(value) < 0 || int.parse(value) > 12) {
                          return 'range: 1-12.';
                        }
                        break;
                    }
                    return null;
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _attributesDropDown() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (nContext, state) {
        return DropdownButtonFormField2(
          decoration: const InputDecoration(labelText: 'Select the attributes'),
          alignment: AlignmentDirectional.centerStart,
          isExpanded: true,
          hint: const Text('All Attributes'),
          items: Attribute.values
              .map(
                (attr) => DropdownMenuItem(
                  enabled: false,
                  value: attr,
                  child: BlocBuilder<HomeCubit, HomeState>(
                      bloc: nContext.read<HomeCubit>(),
                      builder: (
                        BuildContext context,
                        HomeState state,
                      ) {
                        final isSelected =
                            state.selectedAttributes.contains(attr);
                        return InkWell(
                          onTap: () {
                            if (isSelected) {
                              nContext.read<HomeCubit>().removeAttribute(attr);
                            } else {
                              nContext.read<HomeCubit>().addAttribute(attr);
                            }
                          },
                          child: Container(
                            height: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                if (isSelected)
                                  const Icon(Icons.check_box_outlined)
                                else
                                  const Icon(Icons.check_box_outline_blank),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    '${attr.name[0].toUpperCase()}${attr.name.substring(1)}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
              .toList(),
          value: state.selectedAttributes.isEmpty
              ? null
              : state.selectedAttributes.last,
          onChanged: (value) {},
          menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.zero),
          selectedItemBuilder: (context) {
            return Attribute.values.map(
              (attr) {
                return Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    state.selectedStringAttributes.join(', '),
                    textAlign: TextAlign.left,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                );
              },
            ).toList();
          },
        );
      },
    );
  }

  BlocBuilder<HomeCubit, HomeState> _buttons() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                context.read<HomeCubit>().setFiltering(false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (state.secondFormKey.currentState?.validate() ?? false) {
                  context.read<HomeCubit>().setAutovalidateForm(false);
                  Utils.hideKeyboard();

                  String? atk, def, level;
                  if (state.attackTxtController.text.isNotEmpty) {
                    if (state.selectedAttackOperator?.isNotEmpty ?? false) {
                      atk =
                          '${state.selectedAttackOperator!}${state.attackTxtController.text}';
                    } else {
                      atk = state.attackTxtController.text;
                    }
                  }
                  if (state.defenseTxtController.text.isNotEmpty) {
                    if (state.selectedDefenseOperator?.isNotEmpty ?? false) {
                      def =
                          '${state.selectedDefenseOperator!}${state.defenseTxtController.text}';
                    } else {
                      def = state.defenseTxtController.text;
                    }
                  }
                  if (state.levelTxtController.text.isNotEmpty) {
                    if (state.selectedLevelOperator?.isNotEmpty ?? false) {
                      level =
                          '${state.selectedLevelOperator!}${state.levelTxtController.text}';
                    } else {
                      level = state.levelTxtController.text;
                    }
                  }
                  context.read<HomeCubit>().getCards(
                        archetype: state.selectedArchetype,
                        fname: state.nameTxtController.text,
                        types: state.selectedCardTypes,
                        races: state.selectedRaces,
                        atk: atk,
                        def: def,
                        level: level,
                        attributes: state.selectedAttributes,
                      );
                } else {
                  context.read<HomeCubit>().setAutovalidateForm(true);
                }
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }
}
