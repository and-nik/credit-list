import 'package:bank_list/core/api/data/api_data_source.dart';
import 'package:bank_list/features/credit/domain/credit_repo.dart';
import 'package:bank_list/util/builder/app_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'features/app/presentation/app.dart';

void main() {
  setupGetIt();
  runApp(App());
}

void setupGetIt() {
  /// Data sources
  GetIt.I.registerSingleton<IApiDataSource>(AppBuilder.buildApiDataSource(),);

  /// Repos
  GetIt.I.registerLazySingleton<ICreditRepo>(() => CreditRepo(GetIt.I.get<IApiDataSource>(),),);
}