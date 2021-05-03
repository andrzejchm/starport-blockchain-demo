import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';
import 'package:cosmos_wallet_flutter/generated/l10n.dart';

enum _BiometricAuthenticationFailureType {
  Unknown,
  NoBiometricAvailable,
  NotAuthenticated,
}

class BiometricAuthenticationFailure {
  final _BiometricAuthenticationFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const BiometricAuthenticationFailure.unknown() : _type = _BiometricAuthenticationFailureType.Unknown;

  const BiometricAuthenticationFailure.notAuthenticated() : _type = _BiometricAuthenticationFailureType.Unknown;

  const BiometricAuthenticationFailure.noBiometricAvailable()
      : _type = _BiometricAuthenticationFailureType.NoBiometricAvailable;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _BiometricAuthenticationFailureType.Unknown:
        return DisplayableFailure.commonError();
      case _BiometricAuthenticationFailureType.NoBiometricAvailable:
        return DisplayableFailure(
          title: S.current.noBiometricSensorTitle,
          message: S.current.noBiometricSensorMessage,
        );
      case _BiometricAuthenticationFailureType.NotAuthenticated:
        return DisplayableFailure(
          title: S.current.notAuthenticatedTitle,
          message: S.current.notAuthenticatedMessage,
        );
    }
  }
}
