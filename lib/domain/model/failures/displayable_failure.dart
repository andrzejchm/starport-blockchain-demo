import 'package:cosmos_wallet_flutter/generated/l10n.dart';

class DisplayableFailure {
  String title;
  String message;

  DisplayableFailure({
    required this.title,
    required this.message,
  });

  DisplayableFailure.commonError([String? message])
      : title = S.current.commonErrorTitle,
        message = message ?? S.current.commonErrorMessage;
}
