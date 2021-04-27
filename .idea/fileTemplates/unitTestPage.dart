//${PARENT}
#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})
#set( $parentPackage = "#if(${PARENT.isEmpty()})#else${PARENT}/#end")

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:${APP_PACKAGE_NAME}/navigation/app_navigator.dart';
import 'package:${APP_PACKAGE_NAME}/presentation/${parentPackage}${NAME}/${NAME}_initial_params.dart';
import 'package:${APP_PACKAGE_NAME}/presentation/${parentPackage}${NAME}/${NAME}_presenter.dart';
import 'package:${APP_PACKAGE_NAME}/ui/modules/${parentPackage}${NAME}/${NAME}_navigator.dart';
import 'package:${APP_PACKAGE_NAME}/presentation/${parentPackage}${NAME}/${NAME}_presentation_model.dart';
import 'package:${APP_PACKAGE_NAME}/ui/modules/${parentPackage}${NAME}/${NAME}_page.dart';

import '../utils/mocks.dart';
import 'robots/${NAME}_page_robot.dart';
import 'test_app.dart';

void main() {
  ${ClassName}Page page;
  ${ClassName}InitialParams initParams;
  ${ClassName}PresentationModel model;
  ${ClassName}Presenter presenter;
  ${ClassName}Navigator navigator;
  ${ClassName}PageRobot robot;
  
  void _initMvp(WidgetTester tester) {
    initParams = ${ClassName}InitialParams();
    model = ${ClassName}PresentationModel(initParams);
    navigator = ${ClassName}Navigator(AppNavigator());
    presenter = ${ClassName}Presenter(model, navigator);
    page = ${ClassName}Page(initialParams: initParams, presenter: presenter);
    robot = ${ClassName}PageRobot(tester);
  }

  group("${ClassName}Page", () {
    testGoldens("renders correctly", (tester) async {
      _initMvp(tester);
      await tester.pumpWidget(await TestApp.preparePageWidget(() => page));
      await matchMultiScreenGoldens(tester, "${NAME}_page");
    });
    //
    testWidgets("page opens", (tester) async {
        _initMvp(tester);
        await TestApp.pumpPage(tester, () => page);
        await robot.expectPageIsVisible();
    });
    //
  });

  setUp(() {
    Mocks.setUpDefaultMocks();
  });
  
  setUpAll(() async {
    await loadAppFonts();
  });
}