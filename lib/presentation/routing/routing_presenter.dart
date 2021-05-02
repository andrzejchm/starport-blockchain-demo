import 'package:cosmos_wallet_flutter/domain/use_cases/get_wallet_public_info_use_case.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_initial_params.dart';
import 'package:cosmos_wallet_flutter/presentation/routing/routing_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_initial_params.dart';
import 'package:cosmos_wallet_flutter/ui/modules/routing/routing_navigator.dart';

class RoutingPresenter {
  RoutingPresenter(
    this._model,
    this.navigator,
    this._getWalletPublicInfoUseCase,
  );

  final RoutingPresentationModel _model;
  final RoutingNavigator navigator;
  final GetWalletPublicInfoUseCase _getWalletPublicInfoUseCase;

  RoutingViewModel get viewModel => _model;

  Future<void> route() async {
    final walletInfo = (await _getWalletPublicInfoUseCase.execute()).fold((l) => null, (r) => r);

    navigator.close();
    if (walletInfo?.hasWallet ?? false) {
      navigator.openMain(const MainInitialParams());
    } else {
      navigator.openWalletSetup(const WalletSetupInitialParams());
    }
  }
}
