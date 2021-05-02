import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/ui/core/widgets/cosmos_elevated_button.dart';
import 'package:cosmos_wallet_flutter/ui/core/widgets/cosmos_text_field.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class ImportWallet extends StatelessWidget {
  final VoidCallback importWalletClicked;
  final ValueChanged<String> onMnemonicChanged;
  final ValueChanged<String> onNameChanged;
  final bool importEnabled;

  const ImportWallet({
    Key? key,
    required this.importWalletClicked,
    required this.onMnemonicChanged,
    required this.onNameChanged,
    required this.importEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          children: [
            CosmosTextField(
              hint: S.of(context).walletNameHint,
              onChanged: onNameChanged,
            ),
            Expanded(
                child: CosmosTextField(
              hint: S.of(context).recoveryPhraseHint,
              onChanged: onMnemonicChanged,
            )),
            CosmosElevatedButton(onPressed: importWalletClicked, text: S.of(context).importWalletAction)
          ],
        ),
      ),
    );
  }
}
