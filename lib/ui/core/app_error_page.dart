import 'package:flutter/material.dart';

class AppErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        child: Center(
          child: Text("Something went wrong while opening the app :("),
        ),
      ),
    );
  }
}
