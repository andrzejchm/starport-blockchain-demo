import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/presentation/edit_transaction/edit_transaction_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/edit_transaction/edit_transaction_presenter.dart';
import 'package:cosmos_wallet_flutter/ui/core/widgets/cosmos_elevated_button.dart';
import 'package:cosmos_wallet_flutter/ui/core/widgets/cosmos_text_field.dart';
import 'package:cosmos_wallet_flutter/ui/modules/edit_transaction/widgets/balances_dropdown_button.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditTransactionForm extends StatelessWidget {
  const EditTransactionForm({
    Key? key,
    required this.presenter,
    required this.model,
  }) : super(key: key);

  final EditTransactionPresenter presenter;
  final EditTransactionViewModel model;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Column(
        children: [
          CosmosTextField(
            onChanged: presenter.addressChanged,
            hint: S.of(context).addressHint,
          ),
          const SizedBox(height: AppTheme.spacingS),
          CosmosTextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            hint: S.of(context).amountHint,
            onChanged: presenter.amountChanged,
          ),
          const SizedBox(height: AppTheme.spacingS),
          BalancesDropdownButton(
            balances: model.balances,
            onTokenSelected: presenter.onTokenSelected,
            selectedToken: model.token,
          ),
          const SizedBox(height: AppTheme.spacingS),
          if (model.addMemo)
            CosmosTextField(
              hint: S.of(context).memoHint,
              onChanged: presenter.memoChanged,
            )
          else
            CosmosElevatedButton(
              type: CosmosButtonType.secondary,
              onPressed: presenter.addMemoClicked,
              text: S.of(context).addMemoAction,
            ),
          const Expanded(child: SizedBox()),
          CosmosElevatedButton(
            enabled: model.sendTransactionEnabled,
            onPressed: presenter.sendTransactionClicked,
            text: S.of(context).createTransactionAction,
          )
        ],
      ),
    );
  }
}
