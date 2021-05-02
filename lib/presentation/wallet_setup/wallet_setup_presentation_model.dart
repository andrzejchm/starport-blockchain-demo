// ignore_for_file: avoid_setters_without_getters
import 'package:cosmos_wallet_flutter/domain/model/create_wallet_form.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/create_wallet_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/import_wallet_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_initial_params.dart';
import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

enum WalletSetupViewMode {
  intro,
  createWallet,
  importWallet,
  showMnemonic,
}

abstract class WalletSetupViewModel {
  WalletSetupViewMode get currentViewMode;

  List<String> get mnemonic;

  bool get importMnemonicEnabled;
}

class WalletSetupPresentationModel with WalletSetupPresentationModelBase implements WalletSetupViewModel {
  final WalletSetupInitialParams initialParams;

  WalletPrivateInfo get walletInfo => _walletInfo.value;

  WalletSetupPresentationModel(this.initialParams);

  @override
  WalletSetupViewMode get currentViewMode => _currentViewMode.value;

  String get walletName => _walletName.value;

  String get password => _password.value;

  String get confirmPassword => _confirmPassword.value;

  ObservableFuture<Either<CreateWalletFailure, WalletPrivateInfo>>? get createWalletFuture => _createWalletFuture.value;

  CreateWalletForm get createWalletForm => CreateWalletForm(
        name: walletName,
        password: password,
        confirmPassword: confirmPassword,
      );

  @override
  List<String> get mnemonic => walletInfo.mnemonic;

  @override
  bool get importMnemonicEnabled => _importMnemonicEnabled.value;

  String get importMnemonicPhrase => _importMnemonicPhrase.value;

  ObservableFuture<Either<ImportWalletFailure, WalletPublicInfo>>? get importWalletFuture => _importWalletFuture.value;
}

//////////////////BOILERPLATE
abstract class WalletSetupPresentationModelBase {
  //////////////////////////////////////
  final Observable<WalletSetupViewMode> _currentViewMode = Observable(WalletSetupViewMode.intro);

  set currentViewMode(WalletSetupViewMode value) => Action(() => _currentViewMode.value = value)();

  //////////////////////////////////////
  final Observable<String> _confirmPassword = Observable("");

  set confirmPassword(String value) => Action(() => _confirmPassword.value = value)();

  //////////////////////////////////////
  final Observable<String> _password = Observable("");

  set password(String value) => Action(() => _password.value = value)();

  //////////////////////////////////////
  final Observable<String> _walletName = Observable("");

  set walletName(String value) => Action(() => _walletName.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<Either<CreateWalletFailure, WalletPrivateInfo>>?> _createWalletFuture =
      Observable(null);

  set createWalletFuture(ObservableFuture<Either<CreateWalletFailure, WalletPrivateInfo>>? value) =>
      Action(() => _createWalletFuture.value = value)();

  //////////////////////////////////////
  final Observable<WalletPrivateInfo> _walletInfo = Observable(const WalletPrivateInfo());

  set walletInfo(WalletPrivateInfo value) => Action(() => _walletInfo.value = value)();

  //////////////////////////////////////
  final Observable<bool> _importMnemonicEnabled = Observable(false);

  set importMnemonicEnabled(bool value) => Action(() => _importMnemonicEnabled.value = value)();

  //////////////////////////////////////
  final Observable<String> _importMnemonicPhrase = Observable("");

  set importMnemonicPhrase(String value) => Action(() => _importMnemonicPhrase.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<Either<ImportWalletFailure, WalletPublicInfo>>?> _importWalletFuture =
      Observable(null);

  set importWalletFuture(ObservableFuture<Either<ImportWalletFailure, WalletPublicInfo>>? value) =>
      Action(() => _importWalletFuture.value = value)();
}
