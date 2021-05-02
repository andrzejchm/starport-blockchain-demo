import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/ui/core/widgets/cosmos_elevated_button.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MnemonicInfo extends StatelessWidget {
  final List<String> mnemonic;
  final VoidCallback mnemonicSavedClicked;

  const MnemonicInfo({
    Key? key,
    required this.mnemonic,
    required this.mnemonicSavedClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondColOffset = mnemonic.length ~/ 2;
    final firstCol = mnemonic.sublist(0, mnemonic.length ~/ 2);
    final secondCol = mnemonic.sublist(mnemonic.length ~/ 2);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Column(
                  children: [
                    Text(
                      S.of(context).recoveryPhraseTitle,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    Text(
                      S.of(context).recoveryPhraseMessage,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: AppTheme.borderRadiusS,
                        color: Colors.black12,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: buildTextsList(firstCol),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: buildTextsList(secondCol, offset: secondColOffset),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
            child: Column(
              children: [
                CosmosElevatedButton(
                  type: CosmosButtonType.secondary,
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(S.of(context).copiedToClipboardMessage)));
                    Clipboard.setData(ClipboardData(text: mnemonic.join(" ")));
                  },
                  text: S.of(context).copyToClipboardAction,
                ),
                CosmosElevatedButton(
                  onPressed: mnemonicSavedClicked,
                  text: S.of(context).iveSavedItInSecurePlaceAction,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildTextsList(List<String> firstCol, {int offset = 0}) => firstCol
      .asMap()
      .map((index, value) => MapEntry(
          index,
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Text("${offset + index + 1}: $value"),
          )))
      .values
      .toList();
}
