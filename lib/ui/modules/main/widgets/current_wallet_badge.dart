import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/utils/utils.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CurrentWalletBadge extends StatelessWidget {
  final WalletPublicInfo walletInfo;

  const CurrentWalletBadge({
    Key? key,
    required this.walletInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: AppTheme.cardShape,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM, vertical: AppTheme.spacingS),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.redAccent, Colors.greenAccent],
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacingS),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isNullOrBlank(walletInfo.name))
                  Text(
                    walletInfo.name,
                    style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                if (!isNullOrBlank(walletInfo.name)) //
                  const SizedBox(height: AppTheme.spacingXS),
                Text(
                  walletInfo.publicAddress.abbreviateAddress(),
                  style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
