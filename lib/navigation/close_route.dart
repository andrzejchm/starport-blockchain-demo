import 'package:flutter/cupertino.dart';

import 'app_navigator.dart';

abstract class CloseRoute<T> {
  BuildContext get context;

  AppNavigator get appNavigator;

  void close() => appNavigator.close(context);

  void closeWithResult(T result) => appNavigator.closeWithResult(context, result);
}
