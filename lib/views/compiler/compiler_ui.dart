import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'compiler_logic.dart';

class CompilerUi extends StatelessWidget {
  final CompilerLogic logic = Get.put(CompilerLogic());

  CompilerUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Setup"),
    );
  }
}