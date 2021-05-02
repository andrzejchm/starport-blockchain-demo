import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/ui/core/widgets/cosmos_elevated_button.dart';
import 'package:cosmos_wallet_flutter/ui/core/widgets/cosmos_text_field.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CreateWallet extends StatefulWidget {
  final VoidCallback createWalletClicked;
  final ValueChanged<String> nameChanged;
  final ValueChanged<String> passwordChanged;
  final ValueChanged<String> confirmPasswordChanged;

  const CreateWallet({
    Key? key,
    required this.createWalletClicked,
    required this.nameChanged,
    required this.passwordChanged,
    required this.confirmPasswordChanged,
  }) : super(key: key);

  @override
  _CreateWalletState createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  bool _showPassword = false;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController() //
      ..addListener(() => widget.nameChanged(_nameController.text));
    _passwordController = TextEditingController() //
      ..addListener(() => widget.passwordChanged(_passwordController.text));
    _confirmPasswordController = TextEditingController()
      ..addListener(() => widget.confirmPasswordChanged(_confirmPasswordController.text));
  }

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
              controller: _nameController,
              hint: S.of(context).walletNameHint,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: AppTheme.spacingM),
            CosmosTextField(
              controller: _passwordController,
              obscureText: !_showPassword,
              enableSuggestions: false,
              hint: S.of(context).passwordHint,
              suffixIcon: _showPasswordButton(),
            ),
            const SizedBox(height: AppTheme.spacingM),
            CosmosTextField(
              controller: _confirmPasswordController,
              obscureText: !_showPassword,
              enableSuggestions: false,
              hint: S.of(context).confirmPasswordHint,
            ),
            const SizedBox(height: AppTheme.spacingM),
            CosmosElevatedButton(
              onPressed: widget.createWalletClicked,
              text: S.of(context).createAction,
            ),
          ],
        ),
      ),
    );
  }

  Widget _showPasswordButton() {
    return Padding(
      padding: const EdgeInsets.only(right: AppTheme.spacingS),
      child: IconButton(
        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
        visualDensity: VisualDensity.compact,
        iconSize: 16,
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.zero,
        icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
        onPressed: () => setState(() => _showPassword = !_showPassword),
      ),
    );
  }
}
