import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';
import 'package:cosmos_wallet_flutter/generated/l10n.dart';

enum _SendTransactionFailureType {
  Unknown,
  CannotAccessWalletInfo,
}

class SendTransactionFailure {
  final _SendTransactionFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const SendTransactionFailure.unknown() : _type = _SendTransactionFailureType.Unknown;

  const SendTransactionFailure.cannotAccessWalletInfo() : _type = _SendTransactionFailureType.CannotAccessWalletInfo;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _SendTransactionFailureType.Unknown:
        return DisplayableFailure.commonError();
      case _SendTransactionFailureType.CannotAccessWalletInfo:
        return DisplayableFailure(
          title: S.current.walletInfoUnavailableTitle,
          message: S.current.walletInfoUnavailableMessage,
        );
    }
  }
}
