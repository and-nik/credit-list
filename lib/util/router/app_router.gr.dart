// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CreditListScreen]
class CreditListRoute extends PageRouteInfo<void> {
  const CreditListRoute({List<PageRouteInfo>? children})
    : super(CreditListRoute.name, initialChildren: children);

  static const String name = 'CreditListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CreditListScreen());
    },
  );
}

/// generated route for
/// [CreditScreen]
class CreditRoute extends PageRouteInfo<CreditRouteArgs> {
  CreditRoute({
    Key? key,
    required CreditModel credit,
    List<PageRouteInfo>? children,
  }) : super(
         CreditRoute.name,
         args: CreditRouteArgs(key: key, credit: credit),
         initialChildren: children,
       );

  static const String name = 'CreditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreditRouteArgs>();
      return WrappedRoute(
        child: CreditScreen(key: args.key, credit: args.credit),
      );
    },
  );
}

class CreditRouteArgs {
  const CreditRouteArgs({this.key, required this.credit});

  final Key? key;

  final CreditModel credit;

  @override
  String toString() {
    return 'CreditRouteArgs{key: $key, credit: $credit}';
  }
}
