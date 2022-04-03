import 'package:a_8085_helper/res/app_strings.dart';
import 'package:a_8085_helper/res/app_theme.dart';
import 'package:a_8085_helper/views/assembler_screen/assembler_screen_logic.dart';
import 'package:a_8085_helper/views/assembler_screen/assembler_screen_view.dart';
import 'package:a_8085_helper/views/home_view/home_view_ui.dart';
import 'package:a_8085_helper/views/landing_screen/landing_screen_view.dart';
import 'package:a_8085_helper/views/refrence_screen/refrence_screen_view.dart';
import 'package:a_8085_helper/views/splash_view/splash_view_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [BaseApp] contains routes, observers, etc.
class BaseApp extends StatelessWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      getPages: [
        GetPage(name: '/', page: () => const SplashViewView()),
        GetPage(name: '/home', page: () => HomeViewView()),
        GetPage(name: '/assembler', page: () => AssemblerScreenView()),
        GetPage(name: '/landing', page: () => LandingScreenView()),
        GetPage(name: '/reference', page: () => RefrenceScreenView()),
      ],
      initialRoute: '/',
    );
  }
}
