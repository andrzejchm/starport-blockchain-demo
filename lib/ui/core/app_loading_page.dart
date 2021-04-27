import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class AppLoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: AppTheme.darkBlue,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
