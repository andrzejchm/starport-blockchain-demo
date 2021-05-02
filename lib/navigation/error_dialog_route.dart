import 'package:cosmos_wallet_flutter/domain/model/failures/displayable_failure.dart';
import 'package:flutter/material.dart';

abstract class ErrorDialogRoute<T> {
  BuildContext get context;

  Future<void> showError(DisplayableFailure failure) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(failure.title),
          content: Text(failure.message),
        ),
      );
}
