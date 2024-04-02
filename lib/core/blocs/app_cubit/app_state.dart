part of 'app_cubit.dart';

@immutable
sealed class AppState {
  const AppState({this.darkTheme = false});
  final bool darkTheme;
}

final class LightApp extends AppState {
  const LightApp() : super(darkTheme: false);
}

final class DarkApp extends AppState {
  const DarkApp() : super(darkTheme: true);
}
