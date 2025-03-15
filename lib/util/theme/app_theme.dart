import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppTheme {

  AppTheme._();

  static ThemeData get system {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.light ? light : dark;
  }

  static ThemeData get dark {
    return ThemeData.dark(
      useMaterial3: true,
    ).copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get light {
    return ThemeData.light(
      useMaterial3: true,
    ).copyWith(
      appBarTheme: _appBarTheme,
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
      ),
    );
  }

}