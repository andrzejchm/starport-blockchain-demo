// ignore_for_file: avoid_setters_without_getters
import 'package:cosmos_wallet_flutter/domain/model/failures/send_transaction_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/token_balance.dart';
import 'package:cosmos_wallet_flutter/domain/model/token_balances.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction_form.dart';
import 'package:cosmos_wallet_flutter/domain/stores/wallet_store.dart';
import 'package:cosmos_wallet_flutter/domain/utils/utils.dart';
import 'package:cosmos_wallet_flutter/presentation/edit_transaction/edit_transaction_initial_params.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';
import 'package:mobx/mobx.dart';

abstract class EditTransactionViewModel {
  bool get addMemo;

  bool get sendTransactionEnabled;

  TokenBalances get balances;

  TokenBalance get token;
}

class EditTransactionPresentationModel with EditTransactionPresentationModelBase implements EditTransactionViewModel {
  final EditTransactionInitialParams initialParams;
  final WalletStore _walletStore;

  EditTransactionPresentationModel(this.initialParams, this._walletStore) {
    token = _walletStore.tokenBalances.balances.toImmutableList().firstOrNull() ?? const TokenBalance();
  }

  @override
  bool get addMemo => _addMemo.value;

  @override
  bool get sendTransactionEnabled {
    final tokenAmount = double.tryParse(token.amount) ?? 0;
    final specifiedAmount = double.tryParse(amount) ?? 0;
    return !isNullOrBlank(address) && tokenAmount > 0 && specifiedAmount <= tokenAmount;
  }

  String get address => _address.value;

  String get memo => _memo.value;

  String get amount => _amount.value;

  @override
  TokenBalance get token => _token.value;

  @override
  TokenBalances get balances => _walletStore.tokenBalances;

  ObservableFuture<Either<SendTransactionFailure, TransactionHash>>? get sendTransactionFuture =>
      _sendTransactionFuture.value;

  TransactionForm get transactionForm => TransactionForm(
        toAddress: address,
        fromAddress: _walletStore.walletInfo.publicAddress,
        amount: amount,
        denom: token.denom,
        memo: memo,
      );
}

//////////////////BOILERPLATE
abstract class EditTransactionPresentationModelBase {
  //////////////////////////////////////
  final Observable<bool> _addMemo = Observable(false);

  set addMemo(bool value) => Action(() => _addMemo.value = value)();

  //////////////////////////////////////
  final Observable<String> _address = Observable("");

  set address(String value) => Action(() => _address.value = value)();

  //////////////////////////////////////
  final Observable<String> _memo = Observable("");

  set memo(String value) => Action(() => _memo.value = value)();

  //////////////////////////////////////
  final Observable<String> _amount = Observable("");

  set amount(String value) => Action(() => _amount.value = value)();

  //////////////////////////////////////
  final Observable<TokenBalance> _token = Observable(const TokenBalance());

  set token(TokenBalance value) => Action(() => _token.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<Either<SendTransactionFailure, TransactionHash>>?> _sendTransactionFuture =
      Observable(null);

  set sendTransactionFuture(ObservableFuture<Either<SendTransactionFailure, TransactionHash>>? value) =>
      Action(() => _sendTransactionFuture.value = value)();
}
