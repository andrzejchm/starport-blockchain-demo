import 'package:cosmos_wallet_flutter/domain/model/token_balance.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:equatable/equatable.dart';

class TokenBalances extends Equatable {
  final WalletPublicInfo walletInfo;
  final List<TokenBalance> balances;

  const TokenBalances({
    this.walletInfo = const WalletPublicInfo(),
    this.balances = const [],
  });

  @override
  List<Object> get props => [
        walletInfo,
        balances,
      ];
}
