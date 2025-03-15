import 'package:auto_route/auto_route.dart';
import 'package:bank_list/features/credit/domain/credit_repo.dart';
import 'package:bank_list/features/credit/models/credit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/widgets/number_field.dart';
import 'credit_cubit.dart';
import 'credit_state.dart';

@RoutePage()
class CreditScreen extends StatelessWidget implements AutoRouteWrapper {

  final CreditModel credit;

  const CreditScreen({
    super.key,
    required this.credit,
  });

  static const double _fontSize12 = 12;
  static const double _fontSize16 = 16;
  static const double _fontSize18 = 18;
  static const double _space = 10;
  static const int _doubleAsFixed2 = 2;
  static const double _buttonAlpha = 0.2;
  static const EdgeInsets _margin = EdgeInsets.fromLTRB(10, 0, 10, 0);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CreditCubit(
        GetIt.I.get<ICreditRepo>(),
        credit,
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<CreditCubit>(context);

    return BlocBuilder<CreditCubit, CreditState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Credits ${cubit.credit.name}",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
                Text(
                  cubit.credit.bankName,
                  style: TextStyle(
                    fontSize: _fontSize12,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            padding: _margin,
            children: [
              const SizedBox(height: _space,),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Interest rate: ",
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    TextSpan(
                      text: "${credit.interestRate.toStringAsFixed(_doubleAsFixed2)}% ",
                      style: const TextStyle(
                        fontSize: _fontSize16,
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(
                      text: "per year",
                      style: TextStyle(
                          color: Theme.of(context).dividerColor
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Max amount: ",
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    TextSpan(
                      text: "${credit.maxAmount.toStringAsFixed(_doubleAsFixed2)}\$",
                      style: const TextStyle(
                        fontSize: _fontSize18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Up to: ",
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "${credit.maxTerm} months!",
                      style: const TextStyle(
                        fontSize: _fontSize18,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: _space,),
              const SizedBox(height: _space,),

              Row(
                children: [
                  Expanded(
                    child: NumberField(
                      controller: cubit.amountController,
                      suffixText: "\$",
                      placeholderText: "Amount",
                      formatInput: true,
                      enableKeyboardDecimal: true,
                      focusedBorderColor: state.isAmountCorrect
                          ? null
                          : Colors.red,
                      borderColor: state.isAmountCorrect
                          ? null
                          : Colors.red,
                      onChanged: (_) => cubit.checkAmount(),
                    ),
                  ),
                  const SizedBox(width: _space),
                  Expanded(
                    child: NumberField(
                      controller: cubit.termController,
                      suffixText: "months",
                      placeholderText: "Term",
                      formatInput: true,
                      enableKeyboardDecimal: true,
                      focusedBorderColor: state.isTermCorrect
                          ? null
                          : Colors.red,
                      borderColor: state.isTermCorrect
                          ? null
                          : Colors.red,
                      onChanged: (_) => cubit.checkTerm(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: _space,),

              CupertinoButton(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: _buttonAlpha),
                onPressed: cubit.calculateMonthlyPayment,
                child: const Center(
                  child: Text(
                    "Calculate monthly payment",
                  ),
                ),
              ),

              const SizedBox(height: _space,),

              if (state.warningMessage != null)
                Center(
                  child: Text(
                    state.warningMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),

              if (state.monthlyPayment != null)
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "You will pay ",
                          style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: _fontSize16,
                          ),
                        ),
                        TextSpan(
                          text: "${state.monthlyPayment!.toStringAsFixed(_doubleAsFixed2)}\$ ",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: _fontSize18,
                          ),
                        ),
                        TextSpan(
                          text: "per month!",
                          style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: _fontSize16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }



}