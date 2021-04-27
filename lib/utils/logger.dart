import 'package:flutter/cupertino.dart';

// ignore: prefer_function_declarations_over_variables
void Function(dynamic error, dynamic? stack, String? reason) errorLogger = (error, stack, reason) {
  // FirebaseCrashlytics.instance.recordError(
  //   error,
  //   stack is StackTrace ? stack : StackTrace.current,
  //   reason: reason,
  // );
  debugLog(
    "ERROR ${reason == null ? "" : ": $reason"}\n"
    "================\n"
    "error: $error\n"
    "stack: $stack\n"
    "================\n",
  );
};

void logError(dynamic error, [dynamic stack, String? reason]) {
  errorLogger(error, stack, reason);
}

void logErrorIf(bool Function() predicate, dynamic error, [dynamic stack, String? reason]) {
  if (predicate()) {
    logError(error, stack);
  }
}

void debugLog(String message, [dynamic caller]) {
  debugPrint(caller == null ? message : "${caller.runtimeType}: $message");
}
