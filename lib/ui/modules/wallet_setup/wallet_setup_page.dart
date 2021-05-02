import 'package:cosmos_wallet_flutter/dependency_injection/app_component.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_initial_params.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_presenter.dart';
import 'package:cosmos_wallet_flutter/ui/modules/wallet_setup/wallet_setup_navigator.dart';
import 'package:cosmos_wallet_flutter/ui/modules/wallet_setup/widgets/create_wallet.dart';
import 'package:cosmos_wallet_flutter/ui/modules/wallet_setup/widgets/import_wallet.dart';
import 'package:cosmos_wallet_flutter/ui/modules/wallet_setup/widgets/mnemonic_info.dart';
import 'package:cosmos_wallet_flutter/ui/modules/wallet_setup/widgets/wallet_setup_intro.dart';
import 'package:cosmos_wallet_flutter/utils/durations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WalletSetupPage extends StatefulWidget {
  final WalletSetupInitialParams initialParams;
  final WalletSetupPresenter? presenter;

  const WalletSetupPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _WalletSetupPageState createState() => _WalletSetupPageState();
}

class _WalletSetupPageState extends State<WalletSetupPage> {
  late WalletSetupPresenter presenter;

  WalletSetupViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: WalletSetupPresentationModel(widget.initialParams),
          param2: getIt<WalletSetupNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: AnimatedSwitcher(
              duration: const ShortDuration(),
              child: _currentModeWidget(),
            ),
          ),
        );
      },
    );
  }

  Widget _currentModeWidget() {
    Widget child;
    switch (model.currentViewMode) {
      case WalletSetupViewMode.intro:
        child = WalletSetupIntro(
          createNewWalletClicked: presenter.openWalletCreationClicked,
          importExistingWalletClicked: presenter.importExistingWalletClicked,
        );
        break;
      case WalletSetupViewMode.createWallet:
        child = CreateWallet(
          createWalletClicked: presenter.createWalletClicked,
          nameChanged: presenter.walletNameChanged,
          passwordChanged: presenter.walletPasswordChanged,
          confirmPasswordChanged: presenter.walletConfirmPasswordChanged,
        );
        break;
      case WalletSetupViewMode.importWallet:
        child = ImportWallet(
          importWalletClicked: presenter.importWalletClicked,
          onMnemonicChanged: presenter.importMnemonicChanged,
          onNameChanged: presenter.walletNameChanged,
          importEnabled: model.importMnemonicEnabled,
        );
        break;
      case WalletSetupViewMode.showMnemonic:
        child = MnemonicInfo(
          mnemonic: model.mnemonic,
          mnemonicSavedClicked: presenter.mnemonicSavedClicked,
        );
        break;
    }
    return child;
  }
}
