// ignore_for_file: avoid_setters_without_getters
import 'package:cosmos_wallet_flutter/domain/model/failures/get_address_received_transactions_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_address_sent_transactions_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_token_balances_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/paginated_list.dart';
import 'package:cosmos_wallet_flutter/domain/model/token_balances.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/stores/transactions_store.dart';
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
  final TransactionsStore _transactionsStore;

  ObservableFuture<Either<GetTokenBalancesFailure, Unit>>? get getTokenBalancesFuture => _getTokenBalancesFuture.value;

  MainPresentationModel(this.initialParams, this._walletStore, this._transactionsStore);

  @override
  WalletPublicInfo get walletPublicInfo => _walletStore.walletInfo;

  @override
  TokenBalances get tokenBalances => _walletStore.tokenBalances;

  @override
  bool get isLoadingBalances => isFutureInProgress(getTokenBalancesFuture);

  ObservableFuture<Either<GetAddressReceivedTransactionsFailure, Unit>>? get getReceivedTransactionsFuture =>
      _getReceivedTransactionsFuture.value;

  ObservableFuture<Either<GetAddressSentTransactionsFailure, Unit>>? get getSentTransactionsFuture =>
      _getSentTransactionsFuture.value;

  PaginatedList<Transaction> get paginatedReceivedTransactions => _transactionsStore.receivedTransactions;

  PaginatedList<Transaction> get paginatedSentTransactions => _transactionsStore.sentTransactions;

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
  final Observable<ObservableFuture<Either<GetTokenBalancesFailure, Unit>>?> _getTokenBalancesFuture = Observable(null);

  set getTokenBalancesFuture(ObservableFuture<Either<GetTokenBalancesFailure, Unit>>? value) =>
      Action(() => _getTokenBalancesFuture.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<Either<GetAddressReceivedTransactionsFailure, Unit>>?>
      _getReceivedTransactionsFuture = Observable(null);

  set getReceivedTransactionsFuture(ObservableFuture<Either<GetAddressReceivedTransactionsFailure, Unit>>? value) =>
      Action(() => _getReceivedTransactionsFuture.value = value)();
  //////////////////////////////////////
  final Observable<ObservableFuture<Either<GetAddressSentTransactionsFailure, Unit>>?> _getSentTransactionsFuture =
      Observable(null);

  set getSentTransactionsFuture(ObservableFuture<Either<GetAddressSentTransactionsFailure, Unit>>? value) =>
      Action(() => _getSentTransactionsFuture.value = value)();
}
