import 'package:cosmos_wallet_flutter/dependency_injection/app_component.dart';
import 'package:cosmos_wallet_flutter/presentation/routing/routing_initial_params.dart';
import 'package:cosmos_wallet_flutter/presentation/routing/routing_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/routing/routing_presenter.dart';
import 'package:cosmos_wallet_flutter/ui/modules/routing/routing_navigator.dart';
import 'package:flutter/material.dart';

class RoutingPage extends StatefulWidget {
  final RoutingInitialParams initialParams;
  final RoutingPresenter? presenter;

  const RoutingPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _RoutingPageState createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> {
  late RoutingPresenter presenter;

  RoutingViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: RoutingPresentationModel(widget.initialParams),
          param2: getIt<RoutingNavigator>(),
        );
    presenter.navigator.context = context;
    presenter.route();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
