import 'package:bank_list/core/api/data/api_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import '../../../util/core/result.dart';
import '../models/credit_model.dart';

abstract class ICreditRepo {
  Future<Result<List<CreditModel>>> loadCredits();
  double calculateMonthlyPayment(double amount, int term, double rate);
  num? getNum(TextEditingController controller);
}

class CreditRepo implements ICreditRepo {

  final IApiDataSource _apiDataSource;

  CreditRepo(IApiDataSource apiDataSource): _apiDataSource = apiDataSource;

  @override
  Future<Result<List<CreditModel>>> loadCredits() async {
    final res = await _apiDataSource.loadCredits();
    return res.fold(
          (exception) => Failure(exception),
          (value) {
            return Success(value
                .map((e) => CreditModel.fromApi(e))
                .toList(),
            );
          },
    );
  }

  @override
  double calculateMonthlyPayment(double amount, int term, double rate) {
    /// Annuity payment formula
    final i = (rate / 100 / 12);
    final n = term;
    final K = i * math.pow((1 + i), n) / (math.pow((1 + i), n) - 1);

    final S = amount;
    return K * S;
  }

  @override
  num? getNum(TextEditingController controller) {
    return controller.text.isNotEmpty
        ? num.parse(controller.text.replaceAll(RegExp(r','), ''))
        : null;
  }

}