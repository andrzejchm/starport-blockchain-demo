import 'dart:async';

import 'package:cosmos_wallet_flutter/config/app_environment_provider.dart';
import 'package:cosmos_wallet_flutter/ui/cosmos_wallet_app.dart';
import 'package:cosmos_wallet_flutter/utils/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  EquatableConfig.stringify = true;
  FlutterError.onError = (err) => logError(err.exception, err.stack);
  runZonedGuarded(
    () => runApp(const CosmosWalletApp(environment: AppEnvironment.local)),
    (error, stack) => logError(error, stack),
  );
}
