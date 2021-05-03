import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';

enum _LogOutFailureType {
  Unknown,
  SecureStorageError,
}

class LogOutFailure {
  final _LogOutFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const LogOutFailure.unknown() : _type = _LogOutFailureType.Unknown;

  const LogOutFailure.secureStorageError() : _type = _LogOutFailureType.SecureStorageError;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _LogOutFailureType.Unknown:
      case _LogOutFailureType.SecureStorageError:
        return DisplayableFailure.commonError();
    }
  }
}
