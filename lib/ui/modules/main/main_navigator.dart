import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/navigation/app_navigator.dart';
import 'package:cosmos_wallet_flutter/navigation/error_dialog_route.dart';
import 'package:cosmos_wallet_flutter/navigation/no_routes.dart';
import 'package:cosmos_wallet_flutter/navigation/progress_dialog_route.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_initial_params.dart';
import 'package:cosmos_wallet_flutter/ui/modules/edit_transaction/edit_transaction_navigator.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/main_page.dart';
import 'package:cosmos_wallet_flutter/ui/modules/routing/routing_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainNavigator
    with NoRoutes, ErrorDialogRoute, EditTransactionRoute, WalletMoreMenuRoute, ProgressDialogRoute, RoutingRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  MainNavigator(this.appNavigator);
}

abstract class MainRoute {
  Future<void> openMain(MainInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(const MainPage(initialParams: MainInitialParams())),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}

abstract class WalletMoreMenuRoute {
  BuildContext get context;

  Future<void> openWalletMoreMenu({
    required VoidCallback logoutClicked,
  }) =>
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text(S.of(context).walletMenu),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                logoutClicked();
              },
              child: Text(
                S.of(context).logOut,
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).cancelAction),
            ),
          ],
        ),
      );
}
