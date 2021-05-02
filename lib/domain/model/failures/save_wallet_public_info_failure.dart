import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';

enum _SaveWalletPublicInfoFailureType {
  Unknown,
}

class SaveWalletPublicInfoFailure {
  final _SaveWalletPublicInfoFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const SaveWalletPublicInfoFailure.unknown() : _type = _SaveWalletPublicInfoFailureType.Unknown;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _SaveWalletPublicInfoFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }
}
