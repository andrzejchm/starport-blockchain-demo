import 'package:flutter/widgets.dart';

import 'app_navigator.dart';

/// used with navigators that don't have any routes (yet).
abstract class NoRoutes {
  BuildContext get context;

  AppNavigator get appNavigator;
}
