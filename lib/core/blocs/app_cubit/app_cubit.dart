import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const LightApp());

  void toggleTheme() {
    emit(state.darkTheme ? const LightApp() : const DarkApp());
  }
}
