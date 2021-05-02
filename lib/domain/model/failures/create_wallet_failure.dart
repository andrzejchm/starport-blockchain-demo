import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/save_wallet_public_info_failure.dart';
import 'package:cosmos_wallet_flutter/generated/l10n.dart';

enum _CreateWalletFailureType {
  Unknown,
  SecureStorageError,
}

class CreateWalletFailure {
  final _CreateWalletFailureType _type;
  final SaveWalletPublicInfoFailure? storageFailure;

  // ignore: avoid_field_initializers_in_const_classes
  const CreateWalletFailure.unknown()
      : _type = _CreateWalletFailureType.Unknown,
        storageFailure = null;

  const CreateWalletFailure.secureStorageError(this.storageFailure)
      : _type = _CreateWalletFailureType.SecureStorageError;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _CreateWalletFailureType.Unknown:
        return DisplayableFailure.commonError();
      case _CreateWalletFailureType.SecureStorageError:
        return DisplayableFailure(
          title: S.current.keychainErrorTitle,
          message: S.current.keychainErrorMessage,
        );
    }
  }
}
