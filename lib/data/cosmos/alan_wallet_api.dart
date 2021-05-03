import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart' as bank;
import 'package:cosmos_wallet_flutter/config/app_environment_provider.dart';
import 'package:cosmos_wallet_flutter/domain/model/create_wallet_form.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/create_wallet_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_token_balances_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/import_wallet_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/send_transaction_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/token_balance.dart';
import 'package:cosmos_wallet_flutter/domain/model/token_balances.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction_form.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/wallet_api.dart';
import 'package:cosmos_wallet_flutter/domain/transaction_sender.dart';
import 'package:cosmos_wallet_flutter/utils/logger.dart';
import 'package:dartz/dartz.dart';

class AlanWalletApi extends WalletApi {
  final AppEnvironmentProvider appEnvironmentProvider;
  final TransactionSender transactionSender;
  final NetworkInfo _networkInfo;

  late bank.QueryClient _client;

  AlanWalletApi(this.appEnvironmentProvider, this.transactionSender, this._networkInfo) {
    final _clientChannel = appEnvironmentProvider.buildClientChannel();
    _client = bank.QueryClient(_clientChannel);
  }

  @override
  Future<Either<CreateWalletFailure, WalletPrivateInfo>> createRandomWallet(CreateWalletForm form) async {
    final mnemonic = Bip39.generateMnemonic(strength: 256);
    final wallet = Wallet.derive(mnemonic, _networkInfo);
    return right(
      _toWallet(wallet, mnemonic, form.name),
    );
  }

  WalletPrivateInfo _toWallet(Wallet wallet, List<String> mnemonic, String name) {
    return WalletPrivateInfo(
      privateKey: wallet.privateKey,
      mnemonic: mnemonic,
      publicInfo: WalletPublicInfo(
        name: name,
        publicAddress: wallet.bech32Address,
      ),
    );
  }

  @override
  Future<Either<GetTokenBalancesFailure, TokenBalances>> getTokenBalances(WalletPublicInfo walletPublicInfo) async {
    try {
      final result = await _client.allBalances(
        bank.QueryAllBalancesRequest.create()..address = walletPublicInfo.publicAddress,
      );
      final balancesList = result.balances.map((coin) => TokenBalance(denom: coin.denom, amount: coin.amount)).toList();
      return right(
        TokenBalances(
          walletInfo: walletPublicInfo,
          balances: balancesList,
        ),
      );
    } catch (e, stack) {
      logError(e, stack);
      return left(const GetTokenBalancesFailure.unknown());
    }
  }

  @override
  Future<Either<ImportWalletFailure, WalletPrivateInfo>> importWallet(String name, List<String> mnemonicList) async {
    if (!Bip39.validateMnemonic(mnemonicList)) {
      return left(const ImportWalletFailure.invalidMnemonic());
    }
    try {
      return right(_toWallet(Wallet.derive(mnemonicList, _networkInfo), mnemonicList, name));
    } catch (ex, stack) {
      logError(ex, stack);
      return left(const ImportWalletFailure.unknown());
    }
  }

  @override
  Future<Either<SendTransactionFailure, TransactionHash>> sendTransaction(TransactionForm transactionForm) async =>
      transactionSender.sendTransaction(transactionForm);
}
