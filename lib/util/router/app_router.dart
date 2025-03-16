import 'package:auto_route/auto_route.dart';
import 'package:bank_list/features/credit/presentation/credit_list/credit_list_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../features/credit/models/credit_model.dart';
import '../../features/credit/presentation/credit/credit_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: CreditListRoute.page, initial: true),
    AutoRoute(page: CreditRoute.page),
  ];
}