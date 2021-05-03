import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart' as bank;
import 'package:cosmos_wallet_flutter/config/app_environment_provider.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/send_transaction_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction_fee.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction_form.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:cosmos_wallet_flutter/domain/transaction_sender.dart';
import 'package:cosmos_wallet_flutter/domain/utils/utils.dart';
import 'package:cosmos_wallet_flutter/domain/wallet_info_gateway.dart';
import 'package:cosmos_wallet_flutter/utils/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AlanTransactionSender extends TransactionSender {
  final NetworkInfo _networkInfo;
  final WalletInfoGateway _walletInfoGateway;
  final AppEnvironmentProvider _appEnvironmentProvider;

  AlanTransactionSender(
    this._networkInfo,
    this._walletInfoGateway,
    this._appEnvironmentProvider,
  );

  @override
  Future<Either<SendTransactionFailure, TransactionHash>> sendTransaction(TransactionForm transactionForm) async {
    try {
      final clientChannel = _appEnvironmentProvider.buildClientChannel();
      final walletPrivateInfo = (await _walletInfoGateway.gePrivateWalletInfo()).fold((l) => null, (r) => r);
      if (walletPrivateInfo == null) {
        return left(const SendTransactionFailure.cannotAccessWalletInfo());
      }
      final txSigner = TxSigner.build(clientChannel, http.Client());
      final signedTransaction = await txSigner.createAndSign(
        _fromWalletPrivateInfo(walletPrivateInfo),
        [_createMessage(transactionForm)],
        memo: transactionForm.memo,
        fee: transactionForm.fee.toFee(),
      );
      final sender = TxSender.build(clientChannel);
      final result = await sender.broadcastTx(signedTransaction);
      return right(TransactionHash(result.txhash));
    } catch (ex, stack) {
      logError(ex, stack);
      return left(const SendTransactionFailure.unknown());
    }
  }

  bank.MsgSend _createMessage(TransactionForm transactionForm) {
    return bank.MsgSend.create()
      ..fromAddress = transactionForm.fromAddress
      ..toAddress = transactionForm.toAddress
      ..amount.add(
        Coin.create()
          ..denom = transactionForm.denom
          ..amount = transactionForm.amount,
      );
  }

  Wallet _fromWalletPrivateInfo(WalletPrivateInfo walletPrivateInfo) =>
      Wallet.derive(walletPrivateInfo.mnemonic, _networkInfo);
}

extension _AlanTransactionFee on TransactionFee {
  Fee toFee() {
    final fee = Fee();
    fee.gasLimit = gasLimit.toInt64();
    if (!isNullOrBlank(amount) && !isNullOrBlank(denom)) {
      fee.amount.add(Coin.create()
        ..amount = amount
        ..denom = denom);
    }
    return fee;
  }
}
