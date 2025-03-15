import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../credit_filter/credit_filter_screen.dart';
import '../credit_list_cubit.dart';
import '../credit_list_state.dart';


class FilterButton extends StatelessWidget {

  const FilterButton({super.key});

  static const double _iconSize = 24;
  static const double _markSize = 16;
  static const EdgeInsets _markPadding = EdgeInsets.all(5);
  static const double _fontSize12 = 12;
  static const double _border = 7;
  static const EdgeInsets _padding = EdgeInsets.all(5);
  static const double _primaryAlpha = 0.2;
  static const EdgeInsets _margin = EdgeInsets.fromLTRB(0, 5, 5, 0);

  static const double _markPosTop = -2;
  static const double _markPosRight = 0;

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<CreditListCubit>(context);

    return BlocBuilder<CreditListCubit, CreditListState>(
      builder: (context, state) {
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {

            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: CreditFilterScreen(
                    filter: cubit.filter,
                    onApplyFilters: cubit.applyFilter,
                  ),
                );
              },
            );

          },
          child: Stack(
            children: [
              Container(
                margin: _margin,
                padding: _padding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_border),
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: _primaryAlpha),
                ),
                child: Icon(
                  CupertinoIcons.slider_horizontal_3,
                  color: Theme.of(context).colorScheme.primary,
                  size: _iconSize,
                ),
              ),

              if (state.filtersCount > 0)
                Positioned(
                  right: _markPosRight,
                  top: _markPosTop,
                  child: _filterCountMark(state),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _filterCountMark(
      CreditListState state,
      ) {
    return Container(
      padding: _markPadding,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      constraints: const BoxConstraints(
        minWidth: _markSize,
        minHeight: _markSize,
      ),
      child: Center(
        child: Text(
          "${state.filtersCount}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: _fontSize12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}