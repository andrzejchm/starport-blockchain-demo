import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

enum CosmosButtonType { primary, secondary }

class CosmosElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final CosmosButtonType type;
  final bool enabled;

  const CosmosElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.type = CosmosButtonType.primary,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          switch (type) {
            case CosmosButtonType.primary:
              if (states.contains(MaterialState.disabled)) {
                return Theme.of(context).colorScheme.onSurface.withOpacity(0.38);
              } else {
                return Theme.of(context).colorScheme.onSurface;
              }
            case CosmosButtonType.secondary:
              return Theme.of(context).colorScheme.onPrimary;
          }
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          switch (type) {
            case CosmosButtonType.primary:
              if (states.contains(MaterialState.disabled)) {
                return Theme.of(context).colorScheme.onPrimary.withOpacity(0.38);
              } else {
                return Theme.of(context).colorScheme.onPrimary;
              }
            case CosmosButtonType.secondary:
              if (states.contains(MaterialState.disabled)) {
                return Theme.of(context).colorScheme.onSurface.withOpacity(0.38);
              } else {
                return Theme.of(context).colorScheme.onSurface;
              }
          }
        }),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingL,
          vertical: AppTheme.spacingS,
        )),
      ),
      onPressed: enabled ? onPressed : null,
      child: Row(
        children: [
          if (icon != null) Icon(icon),
          Flexible(child: Center(child: Text(text))),
        ],
      ),
    );
  }
}
