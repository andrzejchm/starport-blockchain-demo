// ignore_for_file: avoid_setters_without_getters
import 'package:cosmos_wallet_flutter/domain/model/failures/get_address_received_transactions_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_address_sent_transactions_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_token_balances_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/paginated_list.dart';
import 'package:cosmos_wallet_flutter/domain/model/token_balances.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/stores/wallet_store.dart';
import 'package:cosmos_wallet_flutter/domain/utils/utils.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_initial_params.dart';
import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

abstract class MainViewModel {
  WalletPublicInfo get walletPublicInfo;

  TokenBalances get tokenBalances;

  bool get isLoadingBalances;

  bool get isLoadingSentTransactions;

  bool get isLoadingReceivedTransactions;

  List<Transaction> get receivedTransactions;

  List<Transaction> get sentTransactions;
}

class MainPresentationModel with MainPresentationModelBase implements MainViewModel {
  final MainInitialParams initialParams;
  final WalletStore _walletStore;

  ObservableFuture<Either<GetTokenBalancesFailure, TokenBalances>>? get getTokenBalancesFuture =>
      _getTokenBalancesFuture.value;

  MainPresentationModel(this.initialParams, this._walletStore);

  @override
  WalletPublicInfo get walletPublicInfo => _walletStore.walletInfo;

  @override
  TokenBalances get tokenBalances => _tokenBalances.value;

  @override
  bool get isLoadingBalances => isFutureInProgress(getTokenBalancesFuture);

  ObservableFuture<Either<GetAddressReceivedTransactionsFailure, PaginatedList<Transaction>>>?
      get getReceivedTransactionsFuture => _getReceivedTransactionsFuture.value;

  ObservableFuture<Either<GetAddressSentTransactionsFailure, PaginatedList<Transaction>>>?
      get getSentTransactionsFuture => _getSentTransactionsFuture.value;

  PaginatedList<Transaction> get paginatedReceivedTransactions => _paginatedReceivedTransactions.value;

  PaginatedList<Transaction> get paginatedSentTransactions => _paginatedSentTransactions.value;

  @override
  bool get isLoadingReceivedTransactions => isFutureInProgress(getReceivedTransactionsFuture);

  @override
  bool get isLoadingSentTransactions => isFutureInProgress(getSentTransactionsFuture);

  @override
  List<Transaction> get receivedTransactions => paginatedReceivedTransactions.items;

  @override
  List<Transaction> get sentTransactions => paginatedSentTransactions.items;
}

//////////////////BOILERPLATE
abstract class MainPresentationModelBase {
  //////////////////////////////////////
  final Observable<ObservableFuture<Either<GetTokenBalancesFailure, TokenBalances>>?> _getTokenBalancesFuture =
      Observable(null);

  set getTokenBalancesFuture(ObservableFuture<Either<GetTokenBalancesFailure, TokenBalances>>? value) =>
      Action(() => _getTokenBalancesFuture.value = value)();

  //////////////////////////////////////
  final Observable<TokenBalances> _tokenBalances = Observable(const TokenBalances());

  set tokenBalances(TokenBalances value) => Action(() => _tokenBalances.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<Either<GetAddressReceivedTransactionsFailure, PaginatedList<Transaction>>>?>
      _getReceivedTransactionsFuture = Observable(null);

  set getReceivedTransactionsFuture(
          ObservableFuture<Either<GetAddressReceivedTransactionsFailure, PaginatedList<Transaction>>>? value) =>
      Action(() => _getReceivedTransactionsFuture.value = value)();

  //////////////////////////////////////
  final Observable<PaginatedList<Transaction>> _paginatedReceivedTransactions = Observable(PaginatedList());

  set paginatedReceivedTransactions(PaginatedList<Transaction> value) =>
      Action(() => _paginatedReceivedTransactions.value = value)();

  //////////////////////////////////////
  final Observable<PaginatedList<Transaction>> _paginatedSentTransactions = Observable(PaginatedList());

  set paginatedSentTransactions(PaginatedList<Transaction> value) =>
      Action(() => _paginatedSentTransactions.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<Either<GetAddressSentTransactionsFailure, PaginatedList<Transaction>>>?>
      _getSentTransactionsFuture = Observable(null);

  set getSentTransactionsFuture(
          ObservableFuture<Either<GetAddressSentTransactionsFailure, PaginatedList<Transaction>>>? value) =>
      Action(() => _getSentTransactionsFuture.value = value)();
}
