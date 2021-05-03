import 'package:cosmos_wallet_flutter/domain/model/failures/get_token_balances_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/wallet_api.dart';
import 'package:cosmos_wallet_flutter/domain/stores/wallet_store.dart';
import 'package:dartz/dartz.dart';

class GetTokenBalancesUseCase {
  final WalletApi _walletApi;
  final WalletStore _walletStore;

  GetTokenBalancesUseCase(this._walletApi, this._walletStore);

  Future<Either<GetTokenBalancesFailure, Unit>> execute(WalletPublicInfo walletPublicInfo) async {
    final tokenBalancesResult = await _walletApi.getTokenBalances(walletPublicInfo);
    tokenBalancesResult.fold(
      (l) => null,
      (balances) => _walletStore.tokenBalances = balances,
    );
    return tokenBalancesResult.map((r) => unit);
  }
}
