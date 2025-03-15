import 'package:auto_route/auto_route.dart';
import 'package:bank_list/util/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/credit_model.dart';
import '../credit_list_cubit.dart';

class CreditCell extends StatelessWidget {

  final CreditModel credit;
  
  static const double _border = 15;
  static const double _shadowAlpha = 0.1;
  static const double _spreadRadius = 5;
  static const double _blurRadius = 7;
  static const EdgeInsets _padding = EdgeInsets.all(10);
  static const EdgeInsets _margin = EdgeInsets.fromLTRB(10, 0, 10, 0);
  static const double _fontSize16 = 16;
  static const double _fontSize18 = 18;
  static const double _nameSpace = 10;
  static const double _buttonAlpha = 0.2;
  static const int _doubleAsFixed2 = 2;

  const CreditCell(
      this.credit, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<CreditListCubit>(context);
    cubit.updateView();

    return Container(
      margin: _margin,
      padding: _padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_border),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: _shadowAlpha),
            spreadRadius: _spreadRadius,
            blurRadius: _blurRadius,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            credit.name,
            style: const TextStyle(
              fontSize: _fontSize16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: _nameSpace,),
          Text(
            credit.bankName,
          ),
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

          const SizedBox(height: _nameSpace,),
          CupertinoButton(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: _buttonAlpha),
            onPressed: () {
              AutoRouter.of(context).push(CreditRoute(
                credit: credit,
              ),);
            },
            child: const Center(
              child: Text(
                "Calculate monthly payment",
              ),
            ),
          ),
        ],
      ),
    );
  }



}