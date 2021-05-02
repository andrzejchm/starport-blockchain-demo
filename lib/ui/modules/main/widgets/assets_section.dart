import 'package:cosmos_wallet_flutter/domain/model/token_balance.dart';
import 'package:cosmos_wallet_flutter/domain/model/token_balances.dart';
import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class AssetsSection extends StatelessWidget {
  final TokenBalances tokenBalances;
  final bool isLoading;

  const AssetsSection({
    Key? key,
    required this.tokenBalances,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).assetsTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
        Card(
          shape: AppTheme.cardShape,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Column(
              children: isLoading
                  ? [_loadingView()]
                  : tokenBalances.balances.isEmpty
                      ? [_emptyView(context)]
                      : tokenBalances.balances.map((it) => TokenBalanceRow(tokenBalance: it)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _emptyView(BuildContext context) => SizedBox(
      height: 50,
      child: Center(
          child: Text(
        S.of(context).noBalancesMessage,
        style: const TextStyle(color: Colors.black38, fontSize: 16),
      )));

  Widget _loadingView() => const SizedBox(
        height: 50,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}

class TokenBalanceRow extends StatelessWidget {
  final TokenBalance tokenBalance;

  const TokenBalanceRow({
    Key? key,
    required this.tokenBalance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tokenBalance.denom.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          Text(tokenBalance.amount),
        ],
      ),
    );
  }
}
