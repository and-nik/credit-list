import 'package:bank_list/features/credit/domain/credit_repo.dart';
import 'package:bank_list/features/credit/models/credit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'credit_state.dart';

class CreditCubit extends Cubit<CreditState> {

  final ICreditRepo _creditRepo;

  final CreditModel credit;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController termController = TextEditingController();

  double? _monthlyPayment;
  bool _isAmountCorrect = true;
  bool _isTermCorrect = true;
  String? _warningMessage;

  CreditCubit(
      this._creditRepo,
      this.credit,
      ):super(CreditState(
    monthlyPayment: null,
    isAmountCorrect: true,
    isTermCorrect: true,
    warningMessage: null,
  ));

  void calculateMonthlyPayment() {
    _monthlyPayment = null;
    _isAmountCorrect = true;
    _isTermCorrect = true;
    _warningMessage = null;
    final amount = _creditRepo.getNum(amountController)?.toDouble();
    final term = _creditRepo.getNum(termController)?.toInt();
    if (amount == null) {
      _isAmountCorrect = false;
      _warningMessage = "Enter credit amount.";
      updateView();
      return;
    }
    if (term == null) {
      _isTermCorrect = false;
      _warningMessage = "Enter credit term.";
      updateView();
      return;
    }
    if (amount > credit.maxAmount) {
      _isAmountCorrect = false;
      _warningMessage = "Input credit amount have to be less then max amount.";
      updateView();
      return;
    }
    if (term > credit.maxTerm) {
      _isTermCorrect = false;
      _warningMessage = "Input credit term have to be less then max term.";
      updateView();
      return;
    }
    _monthlyPayment = _creditRepo.calculateMonthlyPayment(amount, term, credit.interestRate);
    updateView();
  }

  void checkAmount() {
    _isAmountCorrect = true;
    _warningMessage = null;
    final amount = _creditRepo.getNum(amountController)?.toDouble();
    if (amount == null) {
      _isAmountCorrect = false;
      _warningMessage = "Enter credit amount.";
      updateView();
      return;
    }
    if (amount > credit.maxAmount) {
      _isAmountCorrect = false;
      _warningMessage = "Input credit amount have to be less then max amount.";
      updateView();
      return;
    }
    updateView();
  }

  void checkTerm() {
    _isTermCorrect = true;
    _warningMessage = null;
    final term = _creditRepo.getNum(termController)?.toInt();
    if (term == null) {
      _isTermCorrect = false;
      _warningMessage = "Enter credit term.";
      updateView();
      return;
    }
    if (term > credit.maxTerm) {
      _isTermCorrect = false;
      _warningMessage = "Input credit term have to be less then max term.";
      updateView();
      return;
    }
    updateView();
  }

  void updateView() {
    emit(CreditState(
      monthlyPayment: _monthlyPayment,
      isAmountCorrect: _isAmountCorrect,
      isTermCorrect: _isTermCorrect,
      warningMessage: _warningMessage,
    ));
  }

}