import 'package:cosmos_wallet_flutter/dependency_injection/app_component.dart';
import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_initial_params.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_presenter.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/main_navigator.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/widgets/assets_section.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/widgets/main_app_bar.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/widgets/transactions_section.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
          param1: MainPresentationModel(widget.initialParams, getIt(), getIt()),
          param2: getIt<MainNavigator>(),
        );
    presenter.navigator.context = context;
    presenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Scaffold(
        appBar: MainAppBar(
          walletInfo: model.walletPublicInfo,
          onWalletClicked: presenter.walletClicked,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CreateTransactionButton(
          createTransactionClicked: presenter.createTransactionClicked,
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => presenter.onRefresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingL),
                    child: AssetsSection(
                      tokenBalances: model.tokenBalances,
                      isLoading: model.isLoadingBalances,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
                    child: TransactionsSection(
                      transactions: model.receivedTransactions,
                      isLoading: model.isLoadingReceivedTransactions,
                      title: S.of(context).receivedTransactions,
                      walletPublicInfo: model.walletPublicInfo,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppTheme.spacingL,
                      right: AppTheme.spacingL,
                      top: AppTheme.spacingS,
                      bottom: AppTheme.spacingL,
                    ),
                    child: TransactionsSection(
                      transactions: model.sentTransactions,
                      isLoading: model.isLoadingSentTransactions,
                      title: S.of(context).sentTransactions,
                      walletPublicInfo: model.walletPublicInfo,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXL * 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateTransactionButton extends StatelessWidget {
  const CreateTransactionButton({
    Key? key,
    required this.createTransactionClicked,
  }) : super(key: key);

  final VoidCallback createTransactionClicked;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: createTransactionClicked,
      icon: const Icon(Icons.arrow_right),
      label: Text(S.of(context).createTransactionAction),
    );
  }
}
