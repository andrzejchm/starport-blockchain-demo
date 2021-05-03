import 'package:cosmos_wallet_flutter/domain/model/failures/get_address_sent_transactions_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/paginated_list.dart';
import 'package:cosmos_wallet_flutter/domain/model/pagination.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/transactions_api.dart';
import 'package:cosmos_wallet_flutter/domain/stores/transactions_store.dart';
import 'package:cosmos_wallet_flutter/domain/stores/wallet_store.dart';
import 'package:dartz/dartz.dart';

class GetAddressSentTransactionsUseCase {
  final TransactionsApi _transactionsApi;
  final TransactionsStore _transactionsStore;
  final WalletStore _walletStore;

  GetAddressSentTransactionsUseCase(this._transactionsApi, this._transactionsStore, this._walletStore);

  Future<Either<GetAddressSentTransactionsFailure, Unit>> execute({
    WalletPublicInfo? walletPublicInfo,
    bool refresh = false,
  }) async {
    final transactionsResult = await _transactionsApi.getAddressSentTransactions(
      refresh ? const Pagination.firstPage() : _transactionsStore.sentTransactions.nextPage,
      (walletPublicInfo ?? _walletStore.walletInfo).publicAddress,
    );
    transactionsResult.fold(
      (l) => null,
      (transactions) {
        if (refresh) {
          _transactionsStore.sentTransactions = PaginatedList();
        }
        _transactionsStore.sentTransactions = _transactionsStore.sentTransactions.byAppending(transactions);
      },
    );
    return transactionsResult.map((_) => unit);
  }
}
