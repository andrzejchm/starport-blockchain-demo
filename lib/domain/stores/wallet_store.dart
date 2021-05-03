import 'package:cosmos_wallet_flutter/domain/model/token_balances.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:mobx/mobx.dart';

class WalletStore extends _WalletStoreBase {
  WalletPublicInfo get walletInfo => _walletInfo.value;

  TokenBalances get tokenBalances => _tokenBalances.value;
}

// BOILERPLATE
abstract class _WalletStoreBase {
  //////////////////////////////////////
  final Observable<WalletPublicInfo> _walletInfo = Observable(const WalletPublicInfo());

  set walletInfo(WalletPublicInfo value) => Action(() => _walletInfo.value = value)();

  //////////////////////////////////////
  final Observable<TokenBalances> _tokenBalances = Observable(const TokenBalances());

  set tokenBalances(TokenBalances value) => Action(() => _tokenBalances.value = value)();
}
