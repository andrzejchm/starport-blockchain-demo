#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})
import 'package:dartz/dartz.dart';
import 'package:${APP_PACKAGE}/domain/model/failures/${NAME}_failure.dart';

class ${ClassName}UseCase {
  Future<Either<${ClassName}Failure, R>> execute() async {
    
  }
}
