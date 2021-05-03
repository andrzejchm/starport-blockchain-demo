import 'package:cosmos_wallet_flutter/domain/model/failures/send_transaction_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction_form.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/wallet_api.dart';
import 'package:cosmos_wallet_flutter/domain/secure_storage/wallet_secure_storage.dart';
import 'package:cosmos_wallet_flutter/domain/stores/transactions_store.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_address_received_transactions_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_address_sent_transactions_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_token_balances_use_case.dart';
import 'package:cosmos_wallet_flutter/utils/logger.dart';
import 'package:dartz/dartz.dart';

class SendTransactionUseCase {
  final WalletApi _walletApi;
  final GetTokenBalancesUseCase _getTokenBalancesUseCase;
  final GetAddressSentTransactionsUseCase _getAddressSentTransactionsUseCase;
  final GetAddressReceivedTransactionsUseCase _getAddressReceivedTransactionsUseCase;
  final WalletSecureStorage _walletSecureStorage;
  final TransactionsStore _transactionsStore;

  SendTransactionUseCase(
    this._walletApi,
    this._getTokenBalancesUseCase,
    this._walletSecureStorage,
    this._getAddressSentTransactionsUseCase,
    this._getAddressReceivedTransactionsUseCase,
    this._transactionsStore,
  );

  Future<Either<SendTransactionFailure, TransactionHash>> execute(TransactionForm transactionForm) async {
    final sendTransactionResult = await _walletApi.sendTransaction(transactionForm);
    sendTransactionResult.fold((l) => null, (hash) {
      _refreshBalancesAndTransactions(hash);
    });
    return sendTransactionResult;
  }

  Future<void> _refreshBalancesAndTransactions(TransactionHash hash) async {
    final publicInfo = (await _walletSecureStorage.getWalletPublicInfo()).getOrElse(() => const WalletPublicInfo());
    var contains = false;
    while (!contains) {
      await Future.delayed(const Duration(seconds: 2)) // TODO make it listen for transaction status instead of waiting
          .then((_) async {
        _getAddressReceivedTransactionsUseCase.execute(walletPublicInfo: publicInfo, refresh: true);
        _getTokenBalancesUseCase.execute(publicInfo);
        await _getAddressSentTransactionsUseCase.execute(walletPublicInfo: publicInfo, refresh: true);
        contains = _transactionsStore.sentTransactions.items.any((element) => element.hash == hash);
        debugLog("Refreshed transactions, does sent transactions just executed transaction? $contains");
      });
    }
    debugLog("Successfully refreshed all data after sending");
  }
}
