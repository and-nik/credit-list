import 'package:bank_list/features/credit/domain/credit_repo.dart';
import 'package:bank_list/features/credit/models/credit_sort_type.dart';
import 'package:bank_list/features/credit/models/filter_model.dart';
import 'package:bank_list/features/credit/models/sort_order_type.dart';
import 'package:bank_list/features/credit/presentation/credit_list/credit_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/credit_model.dart';

class CreditListCubit extends Cubit<CreditListState> {

  final ICreditRepo _creditRepo;

  List<CreditModel> credits = [];
  List<CreditModel> _initialCredits = [];

  Exception? _error;
  bool _isLoad = true;
  CreditSortType? _activeSort;
  SortOrderType? _sortOrder;

  final FilterModel filter = FilterModel();
  int _filtersCount = 0;

  CreditListCubit(
      this._creditRepo,
      ):
  super(CreditListState(
        error: null,
        isLoad: true,
        activeSort: null,
        sortOrder: null,
        filtersCount: 0,
      )){
    loadCredits();
  }

  Future loadCredits() async {
    final res = await _creditRepo.loadCredits();
    res.fold(
          (exception) {
            _error = exception;
          },
          (value) {
            credits = value;
            _initialCredits = [...credits];
          },
    );
    _isLoad = false;
    updateView();
  }

  void changeSortOrder() {
    if (_sortOrder == null || _activeSort == null) return;
    if (_sortOrder == SortOrderType.ascending) {
      _sortOrder = SortOrderType.descending;
    } else {
      _sortOrder = SortOrderType.ascending;
    }
    sortBy(_activeSort!, order: _sortOrder!);
  }

  void sortBy(
      CreditSortType sort, {
        SortOrderType order = SortOrderType.ascending,
      }) {
    _sortOrder ??= order;
    _activeSort = sort;
    updateView();
    credits.sort((a, b) {
      int result;
      switch (sort) {
        case CreditSortType.interestRate:
          result = b.interestRate.compareTo(a.interestRate);
          break;
        case CreditSortType.maxAmount:
          result = b.maxAmount.compareTo(a.maxAmount);
          break;
        case CreditSortType.maxTerm:
          result = b.maxTerm.compareTo(a.maxTerm);
          break;
      }
      return _sortOrder == SortOrderType.ascending ? result : -result;
    });
    _initialCredits.sort((a, b) {
      int result;
      switch (sort) {
        case CreditSortType.interestRate:
          result = b.interestRate.compareTo(a.interestRate);
          break;
        case CreditSortType.maxAmount:
          result = b.maxAmount.compareTo(a.maxAmount);
          break;
        case CreditSortType.maxTerm:
          result = b.maxTerm.compareTo(a.maxTerm);
          break;
      }
      return _sortOrder == SortOrderType.ascending ? result : -result;
    });
    updateView();
  }

  // Future reloadCredits() async {
  //   _error = null;
  //   _isLoad = true;
  //   credits = [];
  //   updateView();
  //   await loadCredits();
  //   if (_sortOrder == null || _activeSort == null) return;
  //   sortBy(_activeSort!, order: _sortOrder!);
  // }

  void applyFilter() {
    credits = [..._initialCredits];
    double? maxAmount = filter.maxAmount;
    double? minAmount = filter.minAmount;
    int? maxTerm = filter.maxTerm;
    int? minTerm = filter.minTerm;
    credits = credits.where((e) {
      bool matchesAmount = (minAmount == null || e.maxAmount >= minAmount) &&
          (maxAmount == null || e.maxAmount <= maxAmount);
      bool matchesTerm = (minTerm == null || e.maxTerm >= minTerm) &&
          (maxTerm == null || e.maxTerm <= maxTerm);
      return matchesAmount && matchesTerm;
    }).toList();
    _filtersCount = 0;
    _filtersCount = [maxAmount, minAmount, maxTerm, minTerm]
        .where((e) => e != null)
        .length;
    updateView();
  }

  void updateView() {
    if (isClosed) return;
    emit(CreditListState(
      error: _error,
      isLoad: _isLoad,
      activeSort: _activeSort,
      sortOrder: _sortOrder,
      filtersCount: _filtersCount,
    ));
  }


}