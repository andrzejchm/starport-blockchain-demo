import 'package:cosmos_wallet_flutter/presentation/main/main_presentation_model.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/main_navigator.dart';

class MainPresenter {
  MainPresenter(
    this._model,
    this.navigator,
  );

  final MainPresentationModel _model;
  final MainNavigator navigator;

  MainViewModel get viewModel => _model;
}
