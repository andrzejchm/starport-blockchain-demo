#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})
#set( $parentPackage = "#if(${PARENT.isEmpty()})#else${PARENT}/#end")

import 'package:flutter/foundation.dart';
import 'package:${APP_PACKAGE_NAME}/presentation/${parentPackage}${NAME}/${NAME}_initial_params.dart';
import 'package:${APP_PACKAGE_NAME}/presentation/${parentPackage}${NAME}/${NAME}_presentation_model.dart';
import 'package:${APP_PACKAGE_NAME}/ui/modules/${parentPackage}${NAME}/${NAME}_navigator.dart';

class ${ClassName}Presenter {

  ${ClassName}Presenter(
    this._model, 
    this.navigator,
  );
  
  final ${ClassName}PresentationModel _model;
  final ${ClassName}Navigator navigator;

  ${ClassName}ViewModel get viewModel => _model;
}