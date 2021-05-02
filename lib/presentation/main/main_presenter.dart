import 'package:cosmos_wallet_flutter/domain/use_cases/get_address_received_transactions_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_address_sent_transactions_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_token_balances_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/utils/utils.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_presentation_model.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/main_navigator.dart';

class MainPresenter {
  MainPresenter(
    this._model,
    this.navigator,
    this._getTokenBalancesUseCase,
    this._getSentTransactionsUseCase,
    this._getReceivedTransactionsUseCase,
  );

  final MainPresentationModel _model;
  final MainNavigator navigator;
  final GetTokenBalancesUseCase _getTokenBalancesUseCase;
  final GetAddressSentTransactionsUseCase _getSentTransactionsUseCase;
  final GetAddressReceivedTransactionsUseCase _getReceivedTransactionsUseCase;

  MainViewModel get viewModel => _model;

  void init() => _loadBalances();

  void _loadBalances() {
    _model.getTokenBalancesFuture = _getTokenBalancesUseCase
        .execute(_model.walletPublicInfo) //
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (balances) => _model.tokenBalances = balances,
        );
    _model.getReceivedTransactionsFuture = _getReceivedTransactionsUseCase
        .execute(_model.paginatedReceivedTransactions.nextPage, _model.walletPublicInfo) //
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (receivedTransactions) => _model.paginatedReceivedTransactions =
              _model.paginatedReceivedTransactions.byAppending(receivedTransactions),
        );
    _model.getSentTransactionsFuture = _getSentTransactionsUseCase
        .execute(_model.paginatedReceivedTransactions.nextPage, _model.walletPublicInfo) //
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (sentTransactions) =>
              _model.paginatedSentTransactions = _model.paginatedSentTransactions.byAppending(sentTransactions),
        );
  }

  void createTransactionClicked() {} //TODO
}
