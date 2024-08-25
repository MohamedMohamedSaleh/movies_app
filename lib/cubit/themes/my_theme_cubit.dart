import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyThemeCubit extends Cubit<ThemeMode> {
  MyThemeCubit() : super(ThemeMode.dark);

  bool isDarkMode = true;
  void toggleTheme({required bool isDark}) {
    isDark ? emit(ThemeMode.dark) : emit(ThemeMode.light);
  }
}
