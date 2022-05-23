import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppStyle appStyle = AppStyle();

class AppStyle with ChangeNotifier {
  ThemeMode get currentTheme => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  bool isDarkTheme = false;

  void toggleTheme(bool val) {
    isDarkTheme = val;
    notifyListeners();
  }

  static const Color primaryColor = Color(0xFF7607FD);
  static const Color accentColor = Color(0xFFFFB412);

  /// A material design text theme with dark glyphs based on Lato.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  ///
  /// This theme uses the Shy version of the font names.
  static const TextTheme blackText = TextTheme(
    headline1: TextStyle(
        debugLabel: 'blackLato headline1',
        inherit: true,
        color: Colors.black54,
        decoration: TextDecoration.none),
    headline2: TextStyle(
        debugLabel: 'blackLato headline2',
        inherit: true,
        color: Colors.black54,
        decoration: TextDecoration.none),
    headline3: TextStyle(
        debugLabel: 'blackLato headline3',
        inherit: true,
        color: Colors.black54,
        decoration: TextDecoration.none),
    headline4: TextStyle(
        debugLabel: 'blackLato headline4',
        inherit: true,
        color: Colors.black54,
        decoration: TextDecoration.none),
    headline5: TextStyle(
        debugLabel: 'blackLato headline5',
        inherit: true,
        color: Colors.black87,
        decoration: TextDecoration.none),
    headline6: TextStyle(
        debugLabel: 'blackLato headline6',
        inherit: true,
        color: Colors.black87,
        decoration: TextDecoration.none),
    bodyText1: TextStyle(
        debugLabel: 'blackLato bodyText1',
        inherit: true,
        color: Colors.black87,
        decoration: TextDecoration.none),
    bodyText2: TextStyle(
        debugLabel: 'blackLato bodyText2',
        inherit: true,
        color: Colors.black87,
        decoration: TextDecoration.none),
    subtitle1: TextStyle(
        debugLabel: 'blackLato subtitle1',
        inherit: true,
        color: Colors.black87,
        decoration: TextDecoration.none),
    subtitle2: TextStyle(
        debugLabel: 'blackLato subtitle2',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    caption: TextStyle(
        debugLabel: 'blackLato caption',
        inherit: true,
        color: Colors.black54,
        decoration: TextDecoration.none),
    button: TextStyle(
        debugLabel: 'blackLato button',
        inherit: true,
        color: Colors.black87,
        decoration: TextDecoration.none),
    overline: TextStyle(
        debugLabel: 'blackLato overline',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
  );

  /// A material design text theme with light glyphs based on Lato.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  ///
  /// This theme uses the Shy version of the font names.
  static const TextTheme whiteText = TextTheme(
    headline1: TextStyle(
        debugLabel: 'whiteLato headline1',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline2: TextStyle(
        debugLabel: 'whiteLato headline2',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline3: TextStyle(
        debugLabel: 'whiteLato headline3',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline4: TextStyle(
        debugLabel: 'whiteLato headline4',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline5: TextStyle(
        debugLabel: 'whiteLato headline5',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    headline6: TextStyle(
        debugLabel: 'whiteLato headline6',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    subtitle1: TextStyle(
        debugLabel: 'whiteLato subtitle1',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    bodyText1: TextStyle(
        debugLabel: 'whiteLato bodyText1',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    bodyText2: TextStyle(
        debugLabel: 'whiteLato bodyText2',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    caption: TextStyle(
        debugLabel: 'whiteLato caption',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    button: TextStyle(
        debugLabel: 'whiteLato button',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    subtitle2: TextStyle(
        debugLabel: 'whiteLato subtitle2',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    overline: TextStyle(
        debugLabel: 'whiteLato overline',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
  );

  /*
	 *  LIGHT THEME
	 */
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: blackText,
    primaryColor: primaryColor,
    accentColor: accentColor,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: ThemeData.light().iconTheme,
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
        color: Colors.white,
        elevation: 1,
        centerTitle: false,
        textTheme: blackText,
        iconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
    bottomNavigationBarTheme:
        ThemeData.light().bottomNavigationBarTheme.copyWith(
              backgroundColor: Colors.white,
              selectedItemColor: primaryColor,
            ),
    cardTheme: ThemeData.light().cardTheme,
    cardColor: ThemeData.light().cardColor,
    buttonTheme: ThemeData.light().buttonTheme.copyWith(
          buttonColor: primaryColor,
          colorScheme: ColorScheme(
            primary: primaryColor,
            primaryVariant: primaryColor,
            secondary: accentColor,
            secondaryVariant: accentColor,
            surface: primaryColor,
            background: primaryColor,
            error: Colors.red,
            onPrimary: primaryColor,
            onSecondary: primaryColor,
            onSurface: primaryColor,
            onBackground: primaryColor,
            onError: Colors.red,
            brightness: Brightness.light,
          ),
        ),
    buttonColor: primaryColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        primary: primaryColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        primary: primaryColor,
      ),
    ),
  );

  /*
	 *  Dark THEME
	 */
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: whiteText,
    primaryColor: primaryColor,
    accentColor: accentColor,
    scaffoldBackgroundColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: ThemeData.dark().iconTheme,
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
          color: Colors.black,
          elevation: 1,
          centerTitle: false,
          textTheme: whiteText,
          shadowColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
    bottomNavigationBarTheme:
        ThemeData.dark().bottomNavigationBarTheme.copyWith(
              backgroundColor: Colors.black,
              selectedItemColor: primaryColor,
            ),
    primaryColorBrightness: Brightness.dark,
  );
}
