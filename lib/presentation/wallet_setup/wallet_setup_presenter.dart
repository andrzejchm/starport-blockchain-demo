import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_presentation_model.dart';
import 'package:cosmos_wallet_flutter/ui/modules/wallet_setup/wallet_setup_navigator.dart';

class WalletSetupPresenter {
  WalletSetupPresenter(
    this._model,
    this.navigator,
  );

  final WalletSetupPresentationModel _model;
  final WalletSetupNavigator navigator;

  WalletSetupViewModel get viewModel => _model;
}
