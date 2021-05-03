import 'package:cosmos_wallet_flutter/domain/biometric_authenticator.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_wallet_private_info_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:cosmos_wallet_flutter/domain/secure_storage/wallet_secure_storage.dart';
import 'package:cosmos_wallet_flutter/domain/wallet_info_gateway.dart';
import 'package:dartz/dartz.dart';

class LocalAuthWalletInfoGateway implements WalletInfoGateway {
  final BiometricAuthenticator _biometricAuthenticator;
  final WalletSecureStorage _walletSecureStorage;

  LocalAuthWalletInfoGateway(this._biometricAuthenticator, this._walletSecureStorage);

  @override
  Future<Either<GetWalletPrivateInfoFailure, WalletPrivateInfo>> gePrivateWalletInfo() async {
    final authResult = await _biometricAuthenticator.authenticate();
    if (authResult.isLeft()) {
      return left(GetWalletPrivateInfoFailure.biometricAuthFailure(authResult.fold((l) => l, (r) => null)));
    }
    return authResult.fold(
      (authFail) => left(GetWalletPrivateInfoFailure.biometricAuthFailure(authFail)),
      (authenticated) async => _walletSecureStorage.getWalletPrivateInfo(),
    );
  }
}
