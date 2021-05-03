import 'package:cosmos_wallet_flutter/navigation/app_navigator.dart';
import 'package:cosmos_wallet_flutter/navigation/close_route.dart';
import 'package:cosmos_wallet_flutter/navigation/no_routes.dart';
import 'package:cosmos_wallet_flutter/presentation/routing/routing_initial_params.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/main_navigator.dart';
import 'package:cosmos_wallet_flutter/ui/modules/routing/routing_page.dart';
import 'package:cosmos_wallet_flutter/ui/modules/wallet_setup/wallet_setup_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoutingNavigator with NoRoutes, CloseRoute, MainRoute, WalletSetupRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  RoutingNavigator(this.appNavigator);
}

abstract class RoutingRoute {
  Future<void> openRouting({required RoutingInitialParams initialParams}) async {
    appNavigator.popUntilRoot(context);

    return appNavigator.push<void>(
      context,
      fadeInRoute(RoutingPage(initialParams: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
