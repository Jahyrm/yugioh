import 'package:flutter/material.dart';

class Utils {
  /// Hide keyboard if it is shown
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
