import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/navigation/app_navigator.dart';
import 'package:cosmos_wallet_flutter/presentation/routing/routing_initial_params.dart';
import 'package:cosmos_wallet_flutter/ui/modules/routing/routing_page.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_localizations/flutter_localizations.dart';

bool isUnitTest = false;

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      theme: AppTheme.buildAppTheme(),
      home: const RoutingPage(initialParams: RoutingInitialParams()),
      supportedLocales: S.delegate.supportedLocales,
      navigatorKey: AppNavigator.navigatorKey,
    );
  }
}
