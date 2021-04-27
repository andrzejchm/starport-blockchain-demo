import 'package:cosmos_wallet_flutter/dependency_injection/app_component.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_initial_params.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_presenter.dart';
import 'package:cosmos_wallet_flutter/ui/modules/wallet_setup/wallet_setup_navigator.dart';
import 'package:flutter/material.dart';

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
    return const Scaffold(
      body: Center(
        child: Text("WalletSetup Page"),
      ),
    );
  }
}
