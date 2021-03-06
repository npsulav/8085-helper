import 'package:a_8085_helper/res/app_strings.dart';
import 'package:a_8085_helper/views/landing_screen/landing_screen_view.dart';
import 'package:a_8085_helper/views/refrence_screen/refrence_screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../assembler_screen/assembler_screen_view.dart';
import '../tools_screen/tools_screen_view.dart';
import 'home_view_logic.dart';

class HomeViewView extends StatefulWidget {
  const HomeViewView({Key? key}) : super(key: key);

  @override
  State<HomeViewView> createState() => _HomeViewViewState();
}

class _HomeViewViewState extends State<HomeViewView> {
  final HomeViewLogic logic = Get.put(HomeViewLogic());
  int position = 1;
  PreloadPageController controller = PreloadPageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        Get.toNamed("/assembler");
        },
        child: const Icon(
            Icons.code
        ),
      ),
      body: PreloadPageView(
        controller: controller,
        onPageChanged: (int index) {
          position = index;
          setState(() {});
        },
        children: [
          SimulatorScreenView(),
          LandingScreenView(),
          ToolsScreenView()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: position,
        onTap: (int index) {
          controller.jumpToPage(index);
          position = index;
          setState(() {});
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.keyboard),
            label: AppStrings.reference,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: AppStrings.assembler,
          ),
        ],
      ),
    );
  }
}
