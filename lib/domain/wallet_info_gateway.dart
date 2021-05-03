import 'package:cosmos_wallet_flutter/domain/model/failures/get_wallet_private_info_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:dartz/dartz.dart';

/// Used to retrieve private wallet info from secure storage only after user successfully grants the wallet permission
abstract class WalletInfoGateway {
  Future<Either<GetWalletPrivateInfoFailure, WalletPrivateInfo>> gePrivateWalletInfo();
}
