import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/widgets/transaction_row.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class TransactionsSection extends StatelessWidget {
  final List<Transaction> transactions;
  final bool isLoading;
  final String title;
  final WalletPublicInfo walletPublicInfo;

  const TransactionsSection({
    Key? key,
    required this.title,
    required this.transactions,
    required this.isLoading,
    required this.walletPublicInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
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
                  : transactions.isEmpty
                      ? [_emptyView(context)]
                      : transactions
                          .map((it) => TransactionRow(
                                transaction: it,
                                walletPublicInfo: walletPublicInfo,
                              ))
                          .toList(),
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
        S.of(context).noTransactionsYetMessage,
        style: const TextStyle(color: Colors.black38, fontSize: 16),
      )));

  Widget _loadingView() => const SizedBox(
        height: 50,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
