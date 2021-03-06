#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})
#set( $parentPackage = "#if(${PARENT.isEmpty()})#else${PARENT}/#end")

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:${APP_PACKAGE_NAME}/navigation/app_navigator.dart';
import 'package:${APP_PACKAGE_NAME}/navigation/no_routes.dart';
import 'package:${APP_PACKAGE_NAME}/presentation/${parentPackage}${NAME}/${NAME}_initial_params.dart';

class ${ClassName}Navigator with NoRoutes {
  @override
  BuildContext context;
  @override
  final AppNavigator appNavigator;

  ${ClassName}Navigator(this.appNavigator);
}

abstract class ${ClassName}Route {

  Future<void> open${ClassName}(${ClassName}InitialParams initialParams) async { TODO() }

  AppNavigator get appNavigator;

  BuildContext get context;

  factory ${ClassName}Route._() => null;
}