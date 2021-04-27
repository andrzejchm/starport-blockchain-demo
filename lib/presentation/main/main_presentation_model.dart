// ignore_for_file: avoid_setters_without_getters
import 'package:cosmos_wallet_flutter/presentation/main/main_initial_params.dart';

abstract class MainViewModel {}

class MainPresentationModel with MainPresentationModelBase implements MainViewModel {
  final MainInitialParams initialParams;

  MainPresentationModel(this.initialParams);
}

//////////////////BOILERPLATE
abstract class MainPresentationModelBase {}
