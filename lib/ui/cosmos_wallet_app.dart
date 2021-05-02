import 'package:cosmos_wallet_flutter/app_widget.dart';
import 'package:cosmos_wallet_flutter/config/app_environment_provider.dart';
import 'package:cosmos_wallet_flutter/dependency_injection/app_component.dart';
import 'package:flutter/material.dart';

class CosmosWalletApp extends StatefulWidget {
  final AppEnvironment environment;

  const CosmosWalletApp({Key? key, required this.environment}) : super(key: key);

  @override
  _CosmosWalletAppState createState() => _CosmosWalletAppState();
}

class _CosmosWalletAppState extends State<CosmosWalletApp> {
  @override
  Widget build(BuildContext context) {
    return AppWidget();
  }

  @override
  void initState() {
    super.initState();
    configureDependencies(widget.environment);
  }
}
