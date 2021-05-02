import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';

enum _GetAddressSentTransactionsFailureType {
  Unknown,
}

class GetAddressSentTransactionsFailure {
  final _GetAddressSentTransactionsFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const GetAddressSentTransactionsFailure.unknown() : _type = _GetAddressSentTransactionsFailureType.Unknown;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GetAddressSentTransactionsFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }
}
