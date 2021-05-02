import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/utils/utils.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class TransactionRow extends StatelessWidget {
  final Transaction transaction;
  final WalletPublicInfo walletPublicInfo;

  const TransactionRow({
    Key? key,
    required this.transaction,
    required this.walletPublicInfo,
  }) : super(key: key);

  bool get isOutgoing => walletPublicInfo.publicAddress == transaction.fromAddress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            transaction.hash,
            maxLines: 1,
            style: const TextStyle(color: Colors.black38, fontSize: 10),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: AppTheme.borderRadiusM,
                  color: isOutgoing ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingS, vertical: AppTheme.spacingXS),
                  child: Text(
                    isOutgoing ? "OUT" : "IN",
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 10),
                  ),
                ),
              ),
              Text(
                "${transaction.amount} ${transaction.tokenDenom.toUpperCase()}",
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingS),
          if (!isNullOrBlank(transaction.memo))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
              child: Text("memo: ${transaction.memo}", maxLines: 1),
            ),
          Text(
            "from: ${transaction.fromAddress}",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black87, fontSize: 12),
          ),
          Text(
            "to: ${transaction.toAddress}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black87, fontSize: 12),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
