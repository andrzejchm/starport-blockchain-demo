import 'package:cosmos_wallet_flutter/domain/model/create_wallet_form.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/create_wallet_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_token_balances_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/import_wallet_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/send_transaction_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/token_balances.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction_form.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:dartz/dartz.dart';

abstract class WalletApi {
  Future<Either<CreateWalletFailure, WalletPrivateInfo>> createRandomWallet(CreateWalletForm form);

  Future<Either<GetTokenBalancesFailure, TokenBalances>> getTokenBalances(WalletPublicInfo walletPublicInfo);

  Future<Either<ImportWalletFailure, WalletPrivateInfo>> importWallet(String name, List<String> mnemonicList);

  Future<Either<SendTransactionFailure, TransactionHash>> sendTransaction(TransactionForm transactionForm);
}
