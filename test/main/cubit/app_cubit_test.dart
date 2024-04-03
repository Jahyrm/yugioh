import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yugioh/core/blocs/app_cubit/app_cubit.dart';

void main() {
  group('AppCubit', () {
    test('el estado inicial del tema es light', () {
      expect(AppCubit().state, const LightApp());
    });

    group('toggleTheme', () {
      blocTest<AppCubit, AppState>(
        'cambio de tema de claro a oscuro',
        build: () => AppCubit(),
        act: (cubit) => cubit.toggleTheme(),
        expect: () => const <AppState>[DarkApp()],
      );
    });
  });
}
