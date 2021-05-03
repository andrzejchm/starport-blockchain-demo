import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class SnackbarRoute {
  BuildContext get context;

  void showSnackBar(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
