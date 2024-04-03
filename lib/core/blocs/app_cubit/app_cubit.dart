import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

/// Este cubit se encuentra en esta estrutura de archivos (dentro de la carpeta
/// "core") por que es un bloc general para toda la app.
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const LightApp());

  /// Método para cambiar el tema de la app.
  void toggleTheme() {
    emit(state.darkTheme ? const LightApp() : const DarkApp());
  }
}
