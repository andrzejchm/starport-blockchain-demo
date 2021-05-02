import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/ui/core/widgets/cosmos_elevated_button.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class WalletSetupIntro extends StatelessWidget {
  final VoidCallback createNewWalletClicked;
  final VoidCallback importExistingWalletClicked;

  const WalletSetupIntro({
    Key? key,
    required this.createNewWalletClicked,
    required this.importExistingWalletClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CosmosElevatedButton(
            icon: Icons.add,
            onPressed: createNewWalletClicked,
            text: S.of(context).createNewWalletAction,
          ),
          const SizedBox(height: AppTheme.spacingM),
          CosmosElevatedButton(
            icon: Icons.publish,
            onPressed: importExistingWalletClicked,
            text: S.of(context).importExistingWallet,
            type: CosmosButtonType.secondary,
          ),
        ],
      ),
    );
  }
}
