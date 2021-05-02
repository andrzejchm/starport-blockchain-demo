import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';
import 'package:cosmos_wallet_flutter/generated/l10n.dart';

enum _GetTokenBalancesFailureType {
  Unknown,
}

class GetTokenBalancesFailure {
  final _GetTokenBalancesFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const GetTokenBalancesFailure.unknown() : _type = _GetTokenBalancesFailureType.Unknown;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GetTokenBalancesFailureType.Unknown:
        return DisplayableFailure(title: S.current.commonErrorTitle, message: S.current.tokenBalancesFetchError);
    }
  }
}
