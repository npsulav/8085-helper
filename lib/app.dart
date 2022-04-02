import 'package:a_8085_helper/res/app_strings.dart';
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
      getPages: [
        GetPage(name: '/', page: () => SplashViewView()),
      ],
      initialRoute: '/',
    );
  }
}
