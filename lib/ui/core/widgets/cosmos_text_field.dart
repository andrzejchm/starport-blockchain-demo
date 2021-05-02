import 'package:cosmos_wallet_flutter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CosmosTextField extends StatefulWidget {
  final String? hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enableSuggestions;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const CosmosTextField({
    Key? key,
    this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.suffixIcon,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  _CosmosTextFieldState createState() => _CosmosTextFieldState();
}

class _CosmosTextFieldState extends State<CosmosTextField> {
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasPrimaryFocus != _hasFocus) {
        setState(() => _hasFocus = _focusNode.hasPrimaryFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = AppTheme.borderRadiusM;
    final focusedColor = Theme.of(context).colorScheme.primary;
    return Card(
      color: Colors.white,
      elevation: 0.2,
      shadowColor: _hasFocus ? focusedColor : Colors.black,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: _hasFocus ? focusedColor : Colors.black12,
          width: 0,
        ),
        borderRadius: radius,
      ),
      child: ClipRRect(
          borderRadius: radius,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingS),
            child: TextField(
              onChanged: widget.onChanged,
              controller: widget.controller,
              obscureText: widget.obscureText,
              enableSuggestions: widget.enableSuggestions,
              keyboardType: widget.keyboardType,
              focusNode: _focusNode,
              decoration: InputDecoration(
                suffix: widget.suffixIcon,
                hintText: widget.hint,
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          )),
    );
  }
}
