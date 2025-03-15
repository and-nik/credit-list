class ApiCreditModel {
  final String id;
  final String name;
  final String bankName;
  final num interestRate;
  final num maxAmount;
  /// in months
  final num maxTerm;

  ApiCreditModel({
    required this.id,
    required this.name,
    required this.bankName,
    required this.interestRate,
    required this.maxAmount,
    required this.maxTerm,
  });

  factory ApiCreditModel.fromJson(dynamic json) {
    return ApiCreditModel(
      id: json["id"],
      name: json["name"],
      bankName: json["bankName"],
      interestRate: json["interestRate"],
      maxAmount: json["maxAmount"],
      maxTerm: json["maxTerm"],
    );
  }
}