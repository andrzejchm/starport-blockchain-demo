import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';
import 'package:cosmos_wallet_flutter/generated/l10n.dart';

enum _ImportWalletFailureType {
  Unknown,
  InvalidMnemonic,
  SecureStorageError,
}

class ImportWalletFailure {
  final _ImportWalletFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const ImportWalletFailure.unknown() : _type = _ImportWalletFailureType.Unknown;

  const ImportWalletFailure.invalidMnemonic() : _type = _ImportWalletFailureType.InvalidMnemonic;

  const ImportWalletFailure.secureStorageError() : _type = _ImportWalletFailureType.SecureStorageError;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _ImportWalletFailureType.Unknown:
        return DisplayableFailure.commonError();
      case _ImportWalletFailureType.InvalidMnemonic:
        return DisplayableFailure(
          title: S.current.invalidMnemonicTitle,
          message: S.current.invalidMnemonicMessage,
        );
      case _ImportWalletFailureType.SecureStorageError:
        return DisplayableFailure(
          title: S.current.keychainErrorTitle,
          message: S.current.keychainErrorMessage,
        );
    }
  }
}
