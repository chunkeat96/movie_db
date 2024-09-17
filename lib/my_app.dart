import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bindings/initial_binding.dart';
import 'config/app_config.dart';
import 'res/colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String get initialRoute {
    return AppRoutes.splashScreenPage;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: GetMaterialApp(
        title: Get.find<AppConfig>().appName,
        theme: _getTheme(),
        getPages: AppPage.routes,
        initialRoute: initialRoute,
        initialBinding: InitialBinding(),
      ),
    );
  }

  ThemeData _getTheme({bool isDarkMode = false}) {
    return ThemeData(
      colorScheme: isDarkMode
          ? const ColorScheme.dark(
        error: Colors.red,
        primary: Colours.primary,
        secondary: Colours.primary,
      )
          : const ColorScheme.light(
          error: Colors.red,
          primary: Colours.primary,
          secondary: Colours.primary),
      scaffoldBackgroundColor: isDarkMode ? Colours.scaffoldDarkBg : Colours.scaffoldBg,
      primaryColor: Colours.primary,
      primaryColorDark: Colours.primaryDark,
      useMaterial3: false,
      iconTheme: const IconThemeData(color: Colors.white),
      highlightColor: const Color.fromRGBO(255, 255, 255, .05),
      splashColor: Colors.transparent,
      bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
      textSelectionTheme:
      const TextSelectionThemeData(cursorColor: Colors.black),
      appBarTheme: AppBarTheme(color: Colors.white, titleTextStyle: GoogleFonts.mulish(
          fontSize: 16.0,
          color: isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500
      )),
      dialogBackgroundColor: Colors.white,
      textTheme: TextTheme(
        titleSmall: isDarkMode
            ? const TextStyle(fontSize: 14, color: Colors.white)
            : const TextStyle(fontSize: 14, color: Colors.black),
        titleMedium: isDarkMode
            ? const TextStyle(fontSize: 14, color: Colors.white)
            : const TextStyle(fontSize: 14, color: Colors.black),
        bodySmall: isDarkMode
            ? const TextStyle(color: Color(0xFF888888), fontSize: 16.0)
            : const TextStyle(color: Color(0xFF888888), fontSize: 16.0),
        bodyMedium: isDarkMode
            ? const TextStyle(color: Color(0xffcccccc), fontSize: 14.0)
            : const TextStyle(color: Colors.black54, fontSize: 14.0),
        // regular
        displaySmall: GoogleFonts.mulish(
            fontSize: 14,
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w400),
        // medium
        displayMedium: GoogleFonts.mulish(
            fontSize: 14,
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500),
        // bold
        displayLarge: GoogleFonts.mulish(
            fontSize: 14,
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w700),
        // light
        headlineSmall: GoogleFonts.mulish(
            fontSize: 14,
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w300),
        // black
        headlineLarge: GoogleFonts.mulish(
            fontSize: 14,
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w900),
        labelSmall: GoogleFonts.mulish(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      tabBarTheme: const TabBarTheme(
        unselectedLabelColor: Colors.white,
        labelColor: Colors.white,
      ),
      dividerColor: Colors.grey,
    );
  }
}
