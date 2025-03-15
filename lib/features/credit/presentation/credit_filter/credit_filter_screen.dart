import 'package:auto_route/auto_route.dart';
import 'package:bank_list/core/widgets/number_field.dart';
import 'package:bank_list/features/credit/domain/credit_repo.dart';
import 'package:bank_list/features/credit/models/filter_model.dart';
import 'package:bank_list/features/credit/presentation/credit_filter/credit_filter_cubit.dart';
import 'package:bank_list/features/credit/presentation/credit_filter/credit_filter_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CreditFilterScreen extends StatelessWidget {

  final FilterModel filter;
  final VoidCallback onApplyFilters;

  const CreditFilterScreen({
        super.key,
        required this.filter,
        required this.onApplyFilters,
      });

  static const EdgeInsets _padding = EdgeInsets.fromLTRB(16, 16, 16, 10);
  static const double _fontSize18 = 18;
  static const double _fontSize16 = 16;
  static const double _mainSpace = 16;
  static const double _space = 10;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreditFilterCubit(
        GetIt.I.get<ICreditRepo>(),
        filter,
      ),
      child: BlocBuilder<CreditFilterCubit, CreditFilterState>(
        builder: (context, state) {

          final cubit = BlocProvider.of<CreditFilterCubit>(context);

          return Container(
            padding: _padding,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Credit filters",
                        style: TextStyle(
                          fontSize: _fontSize18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      CupertinoButton(
                        onPressed: state.isApplyAvailable
                            ? cubit.clear
                            : null,
                        child: const Text("Clear"),
                      )
                    ],
                  ),
                  const SizedBox(height: _mainSpace),

                  const Text(
                    "Credit amount",
                    style: TextStyle(
                      fontSize: _fontSize16,
                    ),
                  ),
                  const SizedBox(height: _space,),

                  Row(
                    children: [
                      Expanded(
                        child: NumberField(
                          controller: cubit.minAmountController,
                          suffixText: "\$",
                          placeholderText: "Up",
                          formatInput: true,
                          enableKeyboardDecimal: true,
                          onChanged: (_) => cubit.updateView(),
                        ),
                      ),
                      const SizedBox(width: _space),
                      Expanded(
                        child: NumberField(
                          controller: cubit.maxAmountController,
                          suffixText: "\$",
                          placeholderText: "To",
                          formatInput: true,
                          enableKeyboardDecimal: true,
                          onChanged: (_) => cubit.updateView(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: _mainSpace),

                  const Text(
                    "Credit term",
                    style: TextStyle(
                      fontSize: _fontSize16,
                    ),
                  ),
                  const SizedBox(height: _space,),
                  Row(
                    children: [
                      Expanded(
                        child: NumberField(
                          controller: cubit.minTermController,
                          suffixText: "months",
                          placeholderText: "Up",
                          onChanged: (_) => cubit.updateView(),
                        ),
                      ),
                      const SizedBox(width: _space),
                      Expanded(
                        child: NumberField(
                          controller: cubit.maxTermController,
                          suffixText: "months",
                          placeholderText: "To",
                          onChanged: (_) => cubit.updateView(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: _mainSpace),

                  CupertinoButton.filled(
                    onPressed: () {
                      cubit.setFilters();
                      onApplyFilters();
                      AutoRouter.of(context).maybePop();
                    },
                    child: const Center(
                      child: Text(
                        "Apply",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

}