import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_view_logic.dart';

class HomeViewView extends StatelessWidget {
  final HomeViewLogic logic = Get.put(HomeViewLogic());

  HomeViewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}