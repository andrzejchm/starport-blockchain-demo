import 'package:cosmos_wallet_flutter/dependency_injection/app_component.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_initial_params.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_presenter.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/main_navigator.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final MainInitialParams initialParams;
  final MainPresenter? presenter;

  const MainPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainPresenter presenter;
  MainViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: MainPresentationModel(widget.initialParams),
          param2: getIt<MainNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Main Page"),
      ),
    );
  }
}
