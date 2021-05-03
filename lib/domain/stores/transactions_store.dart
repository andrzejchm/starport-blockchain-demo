import 'package:cosmos_wallet_flutter/domain/model/paginated_list.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:mobx/mobx.dart';

class TransactionsStore extends _TransactionsStoreBase {
  PaginatedList<Transaction> get receivedTransactions => _receivedTransactions.value;

  PaginatedList<Transaction> get sentTransactions => _sentTransactions.value;
}

abstract class _TransactionsStoreBase {
  //////////////////////////////////////
  final Observable<PaginatedList<Transaction>> _receivedTransactions = Observable(PaginatedList());

  set receivedTransactions(PaginatedList<Transaction> value) => Action(() => _receivedTransactions.value = value)();

  //////////////////////////////////////
  final Observable<PaginatedList<Transaction>> _sentTransactions = Observable(PaginatedList());

  set sentTransactions(PaginatedList<Transaction> value) => Action(() => _sentTransactions.value = value)();
}
