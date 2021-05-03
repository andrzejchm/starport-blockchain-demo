import 'package:cosmos_wallet_flutter/dependency_injection/app_component.dart';
import 'package:cosmos_wallet_flutter/presentation/edit_transaction/edit_transaction_initial_params.dart';
import 'package:cosmos_wallet_flutter/presentation/edit_transaction/edit_transaction_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/edit_transaction/edit_transaction_presenter.dart';
import 'package:cosmos_wallet_flutter/ui/modules/edit_transaction/edit_transaction_navigator.dart';
import 'package:cosmos_wallet_flutter/ui/modules/edit_transaction/widgets/edit_transaction_app_bar.dart';
import 'package:cosmos_wallet_flutter/ui/modules/edit_transaction/widgets/edit_transaction_form.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class EditTransactionPage extends StatefulWidget {
  final EditTransactionInitialParams initialParams;
  final EditTransactionPresenter? presenter;

  const EditTransactionPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _EditTransactionPageState createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  late EditTransactionPresenter presenter;

  EditTransactionViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: EditTransactionPresentationModel(widget.initialParams, getIt()),
          param2: getIt<EditTransactionNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditTransactionAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingL),
          child: EditTransactionForm(presenter: presenter, model: model),
        ),
      ),
    );
  }
}
