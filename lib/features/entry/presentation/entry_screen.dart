import 'package:auto_route/auto_route.dart';
import 'package:bank_list/util/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


@RoutePage()
class EntryScreen extends StatelessWidget {

  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        const CreditListRoute(),
        // CreditRoute(credit: ),
      ],
      builder: (context, child) {
        final tobRotes = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tobRotes.activeIndex,
            onTap: (value) {
              tobRotes.setActiveIndex(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.list_bullet),
                label: "Credits",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chart_bar_alt_fill),
                label: "Calculator",
              ),
            ],
          ),
        );
      },
    );
  }

}