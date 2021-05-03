import 'package:cosmos_wallet_flutter/domain/model/failures/get_wallet_public_info_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/secure_storage/wallet_secure_storage.dart';
import 'package:cosmos_wallet_flutter/domain/stores/wallet_store.dart';
import 'package:dartz/dartz.dart';

class GetWalletPublicInfoUseCase {
  final WalletSecureStorage _walletSecureStorage;
  final WalletStore _walletStore;

  GetWalletPublicInfoUseCase(this._walletSecureStorage, this._walletStore);

  Future<Either<GetWalletPublicInfoFailure, WalletPublicInfo>> execute() async {
    final infoResult = await _walletSecureStorage.getWalletPublicInfo();
    infoResult.fold((_) => null, (info) => _walletStore.walletInfo = info);
    return infoResult;
  }
}
