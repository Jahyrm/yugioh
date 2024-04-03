import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yugioh/app/home/screens/home_screen.dart';
import 'package:yugioh/app/main/screens/main_page.dart';
import 'package:yugioh/core/blocs/app_cubit/app_cubit.dart';
import 'package:yugioh/core/repositories/card_repository.dart';

class MockAuthenticationRepository extends Mock implements CardRepository {}

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

void main() {
  group('AppView', () {
    late AppCubit appCubit;

    setUp(() {
      appCubit = MockAppCubit();
    });

    testWidgets('Navega a la página de inicio automáticamente.',
        (tester) async {
      await tester.pumpWidget(
        BlocProvider.value(value: appCubit, child: const MainPage()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
