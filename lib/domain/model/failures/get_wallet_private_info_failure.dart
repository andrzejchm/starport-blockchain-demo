import 'package:cosmos_wallet_flutter/domain/model/failures/biometric_authentication_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';

enum _GetWalletPrivateInfoFailureType {
  Unknown,
  BiometricAuthFailure,
}

class GetWalletPrivateInfoFailure {
  final _GetWalletPrivateInfoFailureType _type;
  final BiometricAuthenticationFailure? authFailure;

  // ignore: avoid_field_initializers_in_const_classes
  const GetWalletPrivateInfoFailure.unknown()
      : _type = _GetWalletPrivateInfoFailureType.Unknown,
        authFailure = null;

  const GetWalletPrivateInfoFailure.biometricAuthFailure(this.authFailure)
      : _type = _GetWalletPrivateInfoFailureType.BiometricAuthFailure;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GetWalletPrivateInfoFailureType.Unknown:
        return DisplayableFailure.commonError();
      case _GetWalletPrivateInfoFailureType.BiometricAuthFailure:
        return authFailure?.displayableFailure() ?? DisplayableFailure.commonError();
    }
  }
}
