import 'package:auto_route/auto_route.dart';
import 'package:bank_list/features/credit/models/credit_sort_type.dart';
import 'package:bank_list/features/credit/models/sort_order_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'dart:math' as math;

import '../credit_list_cubit.dart';
import '../credit_list_state.dart';

class SortButton extends StatelessWidget {

  const SortButton({super.key});

  static const double _iconSize = 24;
  static const double _sortSpacing = 5;
  static const double _sortSpacingEnd = 10;
  static const double _fontSize14 = 14;
  static const double _rotateInitial = 0;
  static const double _border = 7;
  static const double _arrowSize = 0;
  static const double _primaryAlpha = 0.2;
  static const EdgeInsets _padding = EdgeInsets.all(5);
  static const EdgeInsets _margin = EdgeInsets.fromLTRB(10, 0, 0, 0);

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<CreditListCubit>(context);

    return BlocBuilder<CreditListCubit, CreditListState>(
      builder: (context, state) {

        String? sortString = switch (state.activeSort) {
          CreditSortType.interestRate => "Rate",
          CreditSortType.maxAmount => "Amount",
          CreditSortType.maxTerm => "Term",
          null => null,
        };

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                showPopover(
                  arrowHeight: _arrowSize,
                  arrowWidth: _arrowSize,
                  backgroundColor: Theme.of(context).cardColor,
                  direction: PopoverDirection.top,
                  context: context,
                  bodyBuilder: (context) {
                    return Container(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: _primaryAlpha),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sortCell(context, cubit, state, "Interest rate", CreditSortType.interestRate),
                          _sortCell(context, cubit, state, "Max amount", CreditSortType.maxAmount),
                          _sortCell(context, cubit, state, "Max term", CreditSortType.maxTerm),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: _margin,
                padding: _padding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_border),
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: _primaryAlpha),
                ),
                child: Row(
                  children: [
                    Icon(
                      state.activeSort == null
                          ? CupertinoIcons.archivebox
                          : CupertinoIcons.archivebox_fill,
                      color: Theme.of(context).colorScheme.primary,
                      size: _iconSize,
                    ),
                    if (state.activeSort != null) ...[
                      const SizedBox(width: _sortSpacing,),
                      Text(
                        sortString!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: _fontSize14,
                        ),
                      ),
                      const SizedBox(width: _sortSpacing,),
                    ],
                  ],
                ),
              ),
            ),

            if (state.sortOrder != null) ...[
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: cubit.changeSortOrder,
                child: Transform.rotate(
                  angle: state.sortOrder! == SortOrderType.ascending
                      ? _rotateInitial
                      : math.pi,
                  child: Icon(
                    CupertinoIcons.arrowtriangle_up_fill,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _sortCell(
      BuildContext context,
      CreditListCubit cubit,
      CreditListState state,
      String title,
      CreditSortType sort,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoButton(
          onPressed: () {
            AutoRouter.of(context).maybePop();
            cubit.sortBy(sort);
          },
          child: Text(title),
        ),
        if (state.activeSort == sort) ...[
          const Icon(
            CupertinoIcons.checkmark_alt,
            color: Colors.green,
          ),
          const SizedBox(width: _sortSpacingEnd,),
        ],
      ],
    );
  }

}