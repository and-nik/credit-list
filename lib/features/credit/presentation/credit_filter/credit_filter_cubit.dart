import 'package:bank_list/features/credit/domain/credit_repo.dart';
import 'package:bank_list/features/credit/models/filter_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'credit_filter_state.dart';

class CreditFilterCubit extends Cubit<CreditFilterState> {

  final ICreditRepo _creditRepo;

  final FilterModel _filter;

  final TextEditingController minAmountController = TextEditingController();
  final TextEditingController maxAmountController = TextEditingController();
  final TextEditingController minTermController = TextEditingController();
  final TextEditingController maxTermController = TextEditingController();

  CreditFilterCubit(
      this._creditRepo,
      this._filter):
        super(CreditFilterState(
        isApplyAvailable: false,
      )) {
    minAmountController.text = _filter.minAmount == null ? "" : _filter.minAmount.toString();
    maxAmountController.text = _filter.maxAmount == null ? "" : _filter.maxAmount.toString();
    minTermController.text = _filter.minTerm == null ? "" : _filter.minTerm.toString();
    maxTermController.text = _filter.maxTerm == null ? "" : _filter.maxTerm.toString();
    updateView();
  }

  void setFilters() {
    _filter.minAmount = _creditRepo.getNum(minAmountController)?.toDouble();
    _filter.maxAmount = _creditRepo.getNum(maxAmountController)?.toDouble();
    _filter.minTerm = _creditRepo.getNum(minTermController)?.toInt();
    _filter.maxTerm = _creditRepo.getNum(maxTermController)?.toInt();
  }

  void clear() {
    minAmountController.clear();
    maxAmountController.clear();
    minTermController.clear();
    maxTermController.clear();
    updateView();
  }

  void updateView() {
    final isApplyAvailable = [
      minAmountController.text.isEmpty,
      maxAmountController.text.isEmpty,
      minTermController.text.isEmpty,
      maxTermController.text.isEmpty,
    ].where((e) => e == false)
        .length;

    emit(CreditFilterState(
      isApplyAvailable: isApplyAvailable != 0,
    ));
  }

}