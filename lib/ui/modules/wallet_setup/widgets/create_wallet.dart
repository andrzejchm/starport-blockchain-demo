import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/ui/core/widgets/cosmos_elevated_button.dart';
import 'package:cosmos_wallet_flutter/ui/core/widgets/cosmos_text_field.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CreateWallet extends StatelessWidget {
  final VoidCallback createWalletClicked;
  final ValueChanged<String> nameChanged;

  const CreateWallet({
    Key? key,
    required this.createWalletClicked,
    required this.nameChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).createWalletRationale),
            const SizedBox(height: AppTheme.spacingM),
            CosmosTextField(
              onChanged: nameChanged,
              hint: S.of(context).walletNameHint,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: AppTheme.spacingM),
            CosmosElevatedButton(
              onPressed: createWalletClicked,
              text: S.of(context).createAction,
            ),
          ],
        ),
      ),
    );
  }
}
