import '../../../core/api/model/api_credit_model.dart';

class CreditModel {
  final String id;
  final String name;
  final String bankName;
  final double interestRate;
  final double maxAmount;
  final int maxTerm;

  CreditModel({
    required this.id,
    required this.name,
    required this.bankName,
    required this.interestRate,
    required this.maxAmount,
    required this.maxTerm,
  });

  factory CreditModel.fromApi(ApiCreditModel api) {
    return CreditModel(
      id: api.id,
      name: api.name,
      bankName: api.bankName,
      interestRate: api.interestRate.toDouble(),
      maxAmount: api.maxAmount.toDouble(),
      maxTerm: api.maxTerm.toInt(),
    );
  }

}