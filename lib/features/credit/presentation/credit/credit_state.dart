class CreditState {
  double? monthlyPayment;
  bool isAmountCorrect = true;
  bool isTermCorrect = true;
  String? warningMessage;

  CreditState({
    required this.monthlyPayment,
    required this.isAmountCorrect,
    required this.isTermCorrect,
    required this.warningMessage,
  });
}