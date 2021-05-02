import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';

enum _GetAddressReceivedTransactionsFailureType {
  Unknown,
}

class GetAddressReceivedTransactionsFailure {
  final _GetAddressReceivedTransactionsFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const GetAddressReceivedTransactionsFailure.unknown() : _type = _GetAddressReceivedTransactionsFailureType.Unknown;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GetAddressReceivedTransactionsFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }
}
