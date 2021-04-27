// ignore_for_file: avoid_setters_without_getters
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_initial_params.dart';

abstract class WalletSetupViewModel {}

class WalletSetupPresentationModel with WalletSetupPresentationModelBase implements WalletSetupViewModel {
  final WalletSetupInitialParams initialParams;

  WalletSetupPresentationModel(this.initialParams);
}

//////////////////BOILERPLATE
abstract class WalletSetupPresentationModelBase {}
