import 'package:cosmos_wallet_flutter/navigation/app_navigator.dart';
import 'package:cosmos_wallet_flutter/navigation/close_route.dart';
import 'package:cosmos_wallet_flutter/navigation/error_dialog_route.dart';
import 'package:cosmos_wallet_flutter/navigation/no_routes.dart';
import 'package:cosmos_wallet_flutter/navigation/progress_dialog_route.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_initial_params.dart';
import 'package:cosmos_wallet_flutter/ui/modules/routing/routing_navigator.dart';
import 'package:cosmos_wallet_flutter/ui/modules/wallet_setup/wallet_setup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WalletSetupNavigator with NoRoutes, ErrorDialogRoute, RoutingRoute, CloseRoute, ProgressDialogRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  WalletSetupNavigator(this.appNavigator);
}

abstract class WalletSetupRoute {
  Future<void> openWalletSetup(WalletSetupInitialParams initialParams) async {
    appNavigator.push(context, fadeInRoute(const WalletSetupPage(initialParams: WalletSetupInitialParams())));
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
