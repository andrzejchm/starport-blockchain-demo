import 'package:flutter/material.dart';

class AppNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();

  Future<R?> push<R>(BuildContext context, Route<R> route, {bool useRoot = false}) async =>
      _navigator(context, useRoot: useRoot).push(route);

  void close(BuildContext context) => closeWithResult(context, null);

  void closeWithResult<T>(BuildContext context, T result) => _navigator(context).pop(result);

  void popUntilRoot(BuildContext context) => _navigator(context).popUntil((route) => route.isFirst);
}

Route<T> fadeInRoute<T>(Widget page, {int durationMillis = 250}) => PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: durationMillis),
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: page,
      ),
    );

Route<T> materialRoute<T>(Widget page, {bool fullScreenDialog = false}) => MaterialPageRoute(
      builder: (context) => page,
      fullscreenDialog: fullScreenDialog,
    );

Route<T> slideBottomRoute<T>(Widget page, {int durationMillis = 250, bool fullScreenDialog = false}) =>
    PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: durationMillis),
      fullscreenDialog: fullScreenDialog,
      pageBuilder: (context, animation, secondaryAnimation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutQuint)),
        child: page,
      ),
    );

NavigatorState _navigator(BuildContext context, {bool useRoot = false}) =>
    useRoot ? AppNavigator.navigatorKey.currentState! : Navigator.of(context);
