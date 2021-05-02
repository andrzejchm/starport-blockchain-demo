import 'package:cosmos_wallet_flutter/domain/model/failures/get_wallet_public_info_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/save_wallet_public_info_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:dartz/dartz.dart';

abstract class WalletSecureStorage {
  Future<Either<GetWalletPublicInfoFailure, WalletPrivateInfo>> getWalletPrivateInfo();

  Future<Either<SaveWalletPublicInfoFailure, Unit>> saveWalletPrivateInfo(WalletPrivateInfo walletInfo);
}
