#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})

import 'package:${APP_PACKAGE}/domain/repositories/${NAME}_repository.dart';

class Rest${ClassName}Repository extends ${ClassName}Repository {

}