import 'package:flutter/material.dart';

class AppTheme {
  static const red = Color(0xFFB25E6B);
  static const redDark = Color(0xFF8E4C57);
  static const lightGrey = Color(0xffe4e4e4);
  static const grey = Color(0xFFF1F1F1);
  static const lightBlue = Color(0xFF8E95A8);
  static const darkBlue = Color(0xFF39385A);
  static const green = Color(0xFF5EB16D);
  static const orange = Color(0xFFF5A623);
  static const purple = Color(0xFF9013FE);
  static const themeDarkGray = Color(0xFF969696);
  static const offWhite = Color(0xFFF2F2F2);
  static const incomingMessageColor = Color(0xFFEAEAEB);
  static const outgoingMessageColor = Color(0xFF0F87FF);
  static const outgoingMessageColorSms = Color(0xFF45D65D);
  static const messageErrorColor = Color(0xFFFF3636);

  static const spacingXL = 48.0;
  static const spacingL = 24.0;
  static const spacingM = 12.0;
  static const spacingS = 6.0;
  static const spacingXS = 2.0;

  static const longDuration = 500;
  static const mediumDuration = 300;
  static const shortDuration = 150;

  static const maxFormWidth = 400.0;
  static const wideWidth = 550.0;

  static const radiusL = 20.0;
  static const radiusM = 8.0;
  static const radiusS = 4.0;
  static const BorderRadius borderRadiusM = BorderRadius.all(Radius.circular(radiusM));
  static const BorderRadius borderRadiusS = BorderRadius.all(Radius.circular(radiusS));

  static const elevationS = 4.0;

  static const boxShadowS = BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 2),
    blurRadius: 4,
  );

  static bool isLargeDevice(BuildContext context) => MediaQuery.of(context).size.shortestSide > wideWidth;

  static bool isWideViewport(BuildContext context) => MediaQuery.of(context).size.width > wideWidth;

  static ThemeData buildAppTheme() {
    const colorScheme = ColorScheme(
      primary: red,
      primaryVariant: redDark,
      onPrimary: offWhite,
      secondary: lightBlue,
      secondaryVariant: darkBlue,
      onSecondary: offWhite,
      background: offWhite,
      onBackground: darkBlue,
      surface: Colors.white,
      onSurface: darkBlue,
      brightness: Brightness.light,
      onError: offWhite,
      error: red,
    );
    return ThemeData(
        scaffoldBackgroundColor: offWhite,
        disabledColor: themeDarkGray,
        accentColor: colorScheme.primary,
        primaryColor: colorScheme.primary,
        dividerColor: themeDarkGray,
        focusColor: orange,
        colorScheme: colorScheme,
        textTheme: TextTheme(
          subtitle2: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: darkBlue,
          ),
          headline1: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: darkBlue,
          ),
          headline2: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: darkBlue,
          ),
          headline5: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: darkBlue,
          ),
          headline6: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: darkBlue,
          ),
          caption: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: darkBlue.withOpacity(0.7),
          ),
          bodyText1: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: darkBlue,
          ),
          bodyText2: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: darkBlue,
          ),
        ));
  }
}
