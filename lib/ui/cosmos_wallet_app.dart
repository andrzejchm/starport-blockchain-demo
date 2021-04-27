import 'package:cosmos_wallet_flutter/app_widget.dart';
import 'package:cosmos_wallet_flutter/dependency_injection/app_component.dart';
import 'package:cosmos_wallet_flutter/ui/core/app_error_page.dart';
import 'package:cosmos_wallet_flutter/ui/core/app_loading_page.dart';
import 'package:flutter/material.dart';

class CosmosWalletApp extends StatefulWidget {
  final String environment;

  const CosmosWalletApp({Key? key, required this.environment}) : super(key: key);

  @override
  _CosmosWalletAppState createState() => _CosmosWalletAppState();
}

class _CosmosWalletAppState extends State<CosmosWalletApp> {
  dynamic _error;
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return AppErrorPage();
    } else if (!_initialized) {
      return AppLoadingPage();
    }
    return AppWidget();
  }

  @override
  void initState() {
    super.initState();
    configureDependencies(widget.environment);
  }
}
