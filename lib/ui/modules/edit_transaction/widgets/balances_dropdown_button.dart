import 'package:cosmos_wallet_flutter/domain/model/token_balance.dart';
import 'package:cosmos_wallet_flutter/domain/model/token_balances.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class BalancesDropdownButton extends StatefulWidget {
  final TokenBalances balances;
  final TokenBalance selectedToken;
  final void Function(TokenBalance) onTokenSelected;

  const BalancesDropdownButton({
    Key? key,
    required this.balances,
    required this.onTokenSelected,
    required this.selectedToken,
  }) : super(key: key);

  @override
  _BalancesDropdownButtonState createState() => _BalancesDropdownButtonState();
}

class _BalancesDropdownButtonState extends State<BalancesDropdownButton> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: _focusNode.hasFocus ? Theme.of(context).colorScheme.primary : Colors.black12,
          width: 0,
        ),
        borderRadius: AppTheme.borderRadiusM,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingS),
        child: DropdownButton<TokenBalance>(
          focusNode: _focusNode,
          isExpanded: true,
          onChanged: (balance) => widget.onTokenSelected(balance!),
          value: widget.selectedToken,
          selectedItemBuilder: (context) =>
              widget.balances.balances.map((token) => _menuItem(token, showAmount: false)).toList(),
          items: widget.balances.balances.map((token) => _menuItem(token)).toList(),
        ),
      ),
    );
  }

  DropdownMenuItem<TokenBalance> _menuItem(TokenBalance token, {bool showAmount = true}) {
    return DropdownMenuItem<TokenBalance>(
        value: token,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(token.denom.toUpperCase()),
            if (showAmount) Text(token.amount),
          ],
        ));
  }
}
