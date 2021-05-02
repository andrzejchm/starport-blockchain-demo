import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';

enum _GetWalletPublicInfoFailureType {
  Unknown,
}

class GetWalletPublicInfoFailure {
  final _GetWalletPublicInfoFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const GetWalletPublicInfoFailure.unknown() : _type = _GetWalletPublicInfoFailureType.Unknown;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GetWalletPublicInfoFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }
}
