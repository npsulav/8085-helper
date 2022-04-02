import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_view_logic.dart';

class SplashViewView extends StatelessWidget {
  final SplashViewLogic logic = Get.put(SplashViewLogic());

  SplashViewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Setup"),
    );
  }
}