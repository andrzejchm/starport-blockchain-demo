import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/widgets/current_wallet_badge.dart';
import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final WalletPublicInfo walletInfo;

  const MainAppBar({
    Key? key,
    required this.walletInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: CurrentWalletBadge(walletInfo: walletInfo),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((AppBar().toolbarHeight ?? kToolbarHeight) * 1.2);
}
