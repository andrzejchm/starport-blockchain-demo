import 'package:cosmos_wallet_flutter/domain/use_cases/create_wallet_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/import_wallet_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/utils/utils.dart';
import 'package:cosmos_wallet_flutter/presentation/routing/routing_initial_params.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_presentation_model.dart';
import 'package:cosmos_wallet_flutter/ui/modules/wallet_setup/wallet_setup_navigator.dart';

class WalletSetupPresenter {
  WalletSetupPresenter(
    this._model,
    this.navigator,
    this._createWalletUseCase,
    this._importWalletUseCase,
  );

  final WalletSetupPresentationModel _model;
  final WalletSetupNavigator navigator;
  final CreateWalletUseCase _createWalletUseCase;
  final ImportWalletUseCase _importWalletUseCase;

  WalletSetupViewModel get viewModel => _model;

  void openWalletCreationClicked() => _model.currentViewMode = WalletSetupViewMode.createWallet;

  void importExistingWalletClicked() => _model.currentViewMode = WalletSetupViewMode.importWallet;

  void createWalletClicked() => _model.createWalletFuture = navigator
          .showProgressDialog(
        future: _createWalletUseCase.execute(_model.createWalletForm),
      )
          .observableDoOn(
        (fail) => navigator.showError(fail.displayableFailure()),
        (walletInfo) {
          _model.walletInfo = walletInfo;
          _model.currentViewMode = WalletSetupViewMode.showMnemonic;
        },
      );

  void walletNameChanged(String value) => _model.walletName = value;

  void walletPasswordChanged(String value) => _model.password = value;

  void walletConfirmPasswordChanged(String value) => _model.confirmPassword = value;

  void mnemonicSavedClicked() {
    navigator.close();
    navigator.openRouting(initialParams: const RoutingInitialParams());
  }

  void importWalletClicked() => _model.importWalletFuture = navigator
      .showProgressDialog(
        future: _importWalletUseCase.execute(name: _model.walletName, mnemonic: _model.importMnemonicPhrase),
      )
      .observableDoOn(
        (fail) => navigator.showError(fail.displayableFailure()),
        (success) => navigator.openRouting(initialParams: const RoutingInitialParams()),
      );

  void importMnemonicChanged(String value) {
    _model.importMnemonicPhrase = value;
  }
}
