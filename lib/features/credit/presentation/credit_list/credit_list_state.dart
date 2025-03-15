import 'package:bank_list/features/credit/models/credit_sort_type.dart';

import '../../models/sort_order_type.dart';

class CreditListState {
  final Exception? error;
  final bool isLoad;
  final CreditSortType? activeSort;
  final SortOrderType? sortOrder;
  final int filtersCount;

  CreditListState({
    required this.error,
    required this.isLoad,
    required this.activeSort,
    required this.sortOrder,
    required this.filtersCount,
  });
}