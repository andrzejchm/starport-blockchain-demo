import 'package:cosmos_wallet_flutter/domain/model/failures/log_out_failure.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_address_received_transactions_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_address_sent_transactions_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_token_balances_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/log_out_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/utils/utils.dart';
import 'package:cosmos_wallet_flutter/presentation/edit_transaction/edit_transaction_initial_params.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/routing/routing_initial_params.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/main_navigator.dart';
import 'package:dartz/dartz.dart';

class MainPresenter {
  MainPresenter(
    this._model,
    this.navigator,
    this._getTokenBalancesUseCase,
    this._getSentTransactionsUseCase,
    this._getReceivedTransactionsUseCase,
    this._logOutUseCase,
  );

  final MainPresentationModel _model;
  final MainNavigator navigator;
  final GetTokenBalancesUseCase _getTokenBalancesUseCase;
  final GetAddressSentTransactionsUseCase _getSentTransactionsUseCase;
  final GetAddressReceivedTransactionsUseCase _getReceivedTransactionsUseCase;
  final LogOutUseCase _logOutUseCase;

  MainViewModel get viewModel => _model;

  void init() => _loadBalances();

  Future<void> _loadBalances() async {
    _model.getTokenBalancesFuture = _getTokenBalancesUseCase
        .execute(_model.walletPublicInfo) //
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (balances) => unit,
        );
    _model.getReceivedTransactionsFuture = _getReceivedTransactionsUseCase
        .execute() //
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (receivedTransactions) => unit,
        );
    _model.getSentTransactionsFuture = _getSentTransactionsUseCase
        .execute() //
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (sentTransactions) => unit,
        );
    await Future.wait([
      _model.getTokenBalancesFuture!,
      _model.getReceivedTransactionsFuture!,
      _model.getSentTransactionsFuture!,
    ]);
  }

  void createTransactionClicked() => navigator.openEditTransaction(const EditTransactionInitialParams());

  void walletClicked() => navigator.openWalletMoreMenu(
        logoutClicked: () => _logOut(),
      );

  Future<Either<LogOutFailure, Unit>> _logOut() {
    return navigator.showProgressDialog(future: _logOutUseCase.execute()).doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (success) => navigator.openRouting(initialParams: const RoutingInitialParams()),
        );
  }

  Future<void> onRefresh() => _loadBalances();
}
