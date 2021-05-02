import 'package:cosmos_wallet_flutter/domain/model/failures/get_token_balances_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/token_balances.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/wallet_api.dart';
import 'package:dartz/dartz.dart';

class GetTokenBalancesUseCase {
  final WalletApi _walletApi;

  GetTokenBalancesUseCase(this._walletApi);

  Future<Either<GetTokenBalancesFailure, TokenBalances>> execute(WalletPublicInfo walletPublicInfo) async =>
      _walletApi.getTokenBalances(walletPublicInfo);
}
