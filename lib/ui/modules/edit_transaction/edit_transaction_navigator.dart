import 'package:cosmos_wallet_flutter/navigation/app_navigator.dart';
import 'package:cosmos_wallet_flutter/navigation/close_route.dart';
import 'package:cosmos_wallet_flutter/navigation/error_dialog_route.dart';
import 'package:cosmos_wallet_flutter/navigation/no_routes.dart';
import 'package:cosmos_wallet_flutter/navigation/snackbar_route.dart';
import 'package:cosmos_wallet_flutter/presentation/edit_transaction/edit_transaction_initial_params.dart';
import 'package:cosmos_wallet_flutter/ui/modules/edit_transaction/edit_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditTransactionNavigator with NoRoutes, ErrorDialogRoute, CloseRoute, SnackbarRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  EditTransactionNavigator(this.appNavigator);
}

abstract class EditTransactionRoute {
  Future<void> openEditTransaction(EditTransactionInitialParams initialParams) async =>
      appNavigator.push(context, materialRoute(EditTransactionPage(initialParams: initialParams)));

  AppNavigator get appNavigator;

  BuildContext get context;
}
