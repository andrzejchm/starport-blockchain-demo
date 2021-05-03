import 'package:cosmos_wallet_flutter/domain/biometric_authenticator.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/biometric_authentication_failure.dart';
import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/utils/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';

class LocalBiometricAuthenticator implements BiometricAuthenticator {
  @override
  Future<Either<BiometricAuthenticationFailure, Unit>> authenticate() async {
    try {
      final localAuth = LocalAuthentication();
      if (!await localAuth.canCheckBiometrics) {
        return left(const BiometricAuthenticationFailure.noBiometricAvailable());
      }
      final authResult = await localAuth.authenticate(
          localizedReason: S.current.biometricScanWalletAccessRationale, biometricOnly: false);
      if (!authResult) {
        return left(const BiometricAuthenticationFailure.notAuthenticated());
      }
      return right(unit);
    } catch (ex, stack) {
      logError(ex, stack);
      return left(const BiometricAuthenticationFailure.unknown());
    }
  }
}
