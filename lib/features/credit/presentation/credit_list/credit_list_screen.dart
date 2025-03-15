import 'package:auto_route/auto_route.dart';
import 'package:bank_list/features/credit/domain/credit_repo.dart';
import 'package:bank_list/features/credit/presentation/credit_list/components/credit_cell.dart';
import 'package:bank_list/features/credit/presentation/credit_list/components/filter_button.dart';
import 'package:bank_list/features/credit/presentation/credit_list/components/sort_button.dart';
import 'package:bank_list/features/credit/presentation/credit_list/credit_list_cubit.dart';
import 'package:bank_list/features/credit/presentation/credit_list/credit_list_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class CreditListScreen extends StatelessWidget implements AutoRouteWrapper {

  const CreditListScreen({
    super.key,
  });

  static const double _space = 20;
  static const EdgeInsets _listPadding = EdgeInsets.fromLTRB(0, 20, 0, 20);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CreditListCubit(GetIt.I.get<ICreditRepo>()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<CreditListCubit>(context);

    return BlocBuilder<CreditListCubit, CreditListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.isLoad ? "Loading..." : "Credits ${cubit.credits.length}",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            leadingWidth: 150,
            leading: const SortButton(),
            actions: [
              const FilterButton(),
            ],
          ),
          body: SafeArea(
            child: Builder(
              builder: (context) {
                if (state.isLoad) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                if (state.error != null) {
                  return Center(
                    child: Text(
                      state.error.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                if (cubit.credits.isNotEmpty) {
                  return ListView.separated(
                    padding: _listPadding,
                    itemCount: cubit.credits.length,
                    separatorBuilder: (context, index) => const SizedBox(height: _space,),
                    itemBuilder: (context, index) {
                      return CreditCell(cubit.credits[index]);
                    },
                  );
                }
                return const Center(
                  child: Text(
                    "No credits",
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }



}