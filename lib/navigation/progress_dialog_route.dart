import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

abstract class ProgressDialogRoute {
  BuildContext get context;

  Future<T> showProgressDialog<T>({
    required Future<T> future,
    String? text,
  }) =>
      showDialog<T>(
        barrierDismissible: false,
        context: context,
        builder: (context) => ProgressDialog(
          future: future,
          text: text ?? "",
        ),
      ).then((value) => value as T);
}

class ProgressDialog<T> extends StatefulWidget {
  final Future<T> future;
  final String? text;

  const ProgressDialog({
    Key? key,
    required this.future,
    this.text,
  }) : super(key: key);

  @override
  _ProgressDialogState<T> createState() => _ProgressDialogState<T>();
}

class _ProgressDialogState<T> extends State<ProgressDialog> {
  @override
  void initState() {
    super.initState();
    _awaitFuture();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL, vertical: AppTheme.spacingS),
          child: Row(
            children: [
              const CircularProgressIndicator(),
              if (widget.text != null) const SizedBox(width: AppTheme.spacingL),
              if (widget.text != null) Text(widget.text!),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _awaitFuture() async {
    final result = await widget.future;
    Navigator.pop(context, result);
  }
}
