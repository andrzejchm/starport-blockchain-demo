#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})
#set( $parentPackage = "#if(${PARENT.isEmpty()})#else${PARENT}/#end")
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/src/widget_tester.dart';
import 'package:${APP_PACKAGE_NAME}/ui/modules/${parentPackage}${NAME}/${NAME}_page.dart';

import '../../utils/test_utils.dart';
import 'core/page_robot.dart';
import 'core/widget_robot.dart';

class ${ClassName}PageRobot extends PageRobot<${ClassName}Page> {
  ${ClassName}PageRobot(WidgetTester tester) : super(tester);

}
