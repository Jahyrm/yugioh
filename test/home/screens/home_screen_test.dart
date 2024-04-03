import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yugioh/app/home/cubit/home_cubit.dart';
import 'package:yugioh/app/home/screens/home_screen.dart';
import 'package:yugioh/app/home/widgets/form.dart';
import 'package:yugioh/core/blocs/app_cubit/app_cubit.dart';
import 'package:yugioh/core/models/archetype.dart';
import 'package:yugioh/core/models/card.dart';
import 'package:yugioh/core/repositories/card_repository.dart';

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

class MockCardRepository extends Mock implements CardRepository {}

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

extension on WidgetTester {
  Future<void> pumpHomeScreen(
      CardRepository cardRepository, AppCubit appCubit, HomeCubit homeCubit) {
    return pumpWidget(
      MaterialApp(
        home: RepositoryProvider(
          create: (context) => cardRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: appCubit),
              BlocProvider.value(value: homeCubit),
            ],
            child: const HomeScreen(),
          ),
        ),
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late CardRepository cardsRepository;
  late HomeCubit homeCubit;
  late AppCubit appCubit;

  setUp(() {
    cardsRepository = MockCardRepository();
    homeCubit = MockHomeCubit();
    appCubit = MockAppCubit();
  });

  group('Home Screen', () {
    testWidgets(
        'renderiza CircularProgressIndicator '
        'cuando el estado es inicial', (tester) async {
      when(() => appCubit.state).thenReturn(const LightApp());
      when(() => homeCubit.state).thenReturn(HomeState(
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
      ));
      await tester.pumpHomeScreen(cardsRepository, appCubit, homeCubit);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renderiza el formulario sin lista cuando solo hay archetypes',
        (tester) async {
      when(() => appCubit.state).thenReturn(const LightApp());
      when(() => homeCubit.state).thenReturn(HomeState(
        archetypes: [
          Archetype(name: 'Test'),
          Archetype(name: 'Test 1'),
        ],
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
        loadingHome: false,
        refresh: false,
      ));
      await tester.pumpHomeScreen(cardsRepository, appCubit, homeCubit);
      expect(find.byType(HomeForm), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });
  });

  testWidgets('renderiza el formulario con lista cuando hay cartas',
      (tester) async {
    when(() => appCubit.state).thenReturn(const LightApp());
    when(() => homeCubit.state).thenReturn(HomeState(
      cards: [
        CardModel(type: 'Effect Monster'),
        CardModel(type: 'Pendulum Normal Monster')
      ],
      archetypes: [
        Archetype(name: 'Test'),
        Archetype(name: 'Test 1'),
      ],
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
      loadingHome: false,
      refresh: false,
    ));
    await tester.pumpHomeScreen(cardsRepository, appCubit, homeCubit);
    expect(find.byType(HomeForm), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}
