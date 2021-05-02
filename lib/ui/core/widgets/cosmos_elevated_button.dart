import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

enum CosmosButtonType { primary, secondary }

class CosmosElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final CosmosButtonType type;

  const CosmosElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.type = CosmosButtonType.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          type == CosmosButtonType.primary ? Colors.black87 : Colors.white,
        ),
        foregroundColor: MaterialStateProperty.all(
          type == CosmosButtonType.primary ? Colors.white : Colors.black87,
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingL,
          vertical: AppTheme.spacingS,
        )),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          if (icon != null) Icon(icon),
          Flexible(child: Center(child: Text(text))),
        ],
      ),
    );
  }
}
