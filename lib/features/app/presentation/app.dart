import 'package:bank_list/util/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../util/router/app_router.dart';

class App extends StatelessWidget {

  final AppRouter _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      /// Theme will depend on device theme
      theme: AppTheme.system,
    );
  }
}