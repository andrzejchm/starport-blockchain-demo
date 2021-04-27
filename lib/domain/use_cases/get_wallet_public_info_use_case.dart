import 'package:cosmos_wallet_flutter/domain/model/failures/get_wallet_public_info_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/secure_storage/wallet_secure_storage.dart';
import 'package:dartz/dartz.dart';

class GetWalletPublicInfoUseCase {
  final WalletSecureStorage _walletSecureStorage;

  GetWalletPublicInfoUseCase(this._walletSecureStorage);

  Future<Either<GetWalletPublicInfoFailure, WalletPublicInfo>> execute() => _walletSecureStorage.getWalletPublicInfo();
}
