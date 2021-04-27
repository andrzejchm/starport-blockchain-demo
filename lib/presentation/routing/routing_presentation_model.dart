// ignore_for_file: avoid_setters_without_getters
import 'package:cosmos_wallet_flutter/presentation/routing/routing_initial_params.dart';

abstract class RoutingViewModel {}

class RoutingPresentationModel with RoutingPresentationModelBase implements RoutingViewModel {
  final RoutingInitialParams initialParams;

  RoutingPresentationModel(this.initialParams);
}

//////////////////BOILERPLATE
abstract class RoutingPresentationModelBase {}
