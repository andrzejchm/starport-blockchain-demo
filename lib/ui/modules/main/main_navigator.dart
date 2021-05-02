import 'package:cosmos_wallet_flutter/navigation/app_navigator.dart';
import 'package:cosmos_wallet_flutter/navigation/error_dialog_route.dart';
import 'package:cosmos_wallet_flutter/navigation/no_routes.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_initial_params.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainNavigator with NoRoutes, ErrorDialogRoute {
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
