import 'package:cosmos_wallet_flutter/domain/model/failures/get_address_received_transactions_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/paginated_list.dart';
import 'package:cosmos_wallet_flutter/domain/model/pagination.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/transactions_api.dart';
import 'package:cosmos_wallet_flutter/domain/stores/transactions_store.dart';
import 'package:cosmos_wallet_flutter/domain/stores/wallet_store.dart';
import 'package:dartz/dartz.dart';

class GetAddressReceivedTransactionsUseCase {
  final TransactionsApi _transactionsApi;
  final TransactionsStore _transactionsStore;
  final WalletStore _walletStore;

  GetAddressReceivedTransactionsUseCase(this._transactionsApi, this._transactionsStore, this._walletStore);

  Future<Either<GetAddressReceivedTransactionsFailure, Unit>> execute({
    WalletPublicInfo? walletPublicInfo,
    bool refresh = false,
  }) async {
    final transactionsResult = await _transactionsApi.getAddressReceivedTransactions(
      refresh ? const Pagination.firstPage() : _transactionsStore.receivedTransactions.nextPage,
      (walletPublicInfo ?? _walletStore.walletInfo).publicAddress,
    );
    transactionsResult.fold(
      (l) => null,
      (transactions) {
        if (refresh) {
          _transactionsStore.receivedTransactions = PaginatedList();
        }
        _transactionsStore.receivedTransactions = _transactionsStore.receivedTransactions.byAppending(transactions);
      },
    );
    return transactionsResult.map((_) => unit);
  }
}
