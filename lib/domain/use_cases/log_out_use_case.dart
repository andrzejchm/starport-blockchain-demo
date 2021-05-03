import 'package:cosmos_wallet_flutter/domain/model/failures/log_out_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/paginated_list.dart';
import 'package:cosmos_wallet_flutter/domain/model/token_balances.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/secure_storage/wallet_secure_storage.dart';
import 'package:cosmos_wallet_flutter/domain/stores/transactions_store.dart';
import 'package:cosmos_wallet_flutter/domain/stores/wallet_store.dart';
import 'package:dartz/dartz.dart';

class LogOutUseCase {
  final WalletStore _walletStore;
  final TransactionsStore _transactionsStore;
  final WalletSecureStorage _walletSecureStorage;

  LogOutUseCase(this._walletStore, this._transactionsStore, this._walletSecureStorage);

  Future<Either<LogOutFailure, Unit>> execute() async {
    _walletStore.walletInfo = const WalletPublicInfo();
    _walletStore.tokenBalances = const TokenBalances();
    _transactionsStore.receivedTransactions = PaginatedList();
    _transactionsStore.sentTransactions = PaginatedList();
    return (await _walletSecureStorage.saveWalletPrivateInfo(null)).fold(
      (l) => left(const LogOutFailure.secureStorageError()),
      (r) => right(unit),
    );
  }
}
