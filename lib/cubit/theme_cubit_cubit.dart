import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:netflix/cubit/theme_cubit_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light(Colors.red));

  void toggleTheme({
    Color color = Colors.red,
    bool changeMode = false,
  }) {
    changeMode
        ? emit(state.themeData.brightness == Brightness.dark
            ? ThemeState.light(color)
            : ThemeState.dark(color))
        : emit(state.themeData.brightness == Brightness.dark
            ? ThemeState.dark(color)
            : ThemeState.light(color));
    // if (state.themeData.brightness == Brightness.dark) {
    //   emit(ThemeState.light(color));
    // } else {
    //   emit(ThemeState.dark(color));
    // }
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    return ThemeState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return state.toJson();
  }
}
