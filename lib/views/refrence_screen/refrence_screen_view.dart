/// Generated by Flutter GetX Starter on 2022-04-03 18:58
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'refrence_screen_logic.dart';

class RefrenceScreenView extends StatelessWidget {
  final RefrenceScreenLogic logic = Get.put(RefrenceScreenLogic());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset("assets/logo.jpg"),
        ),
        Text("In Progress - 8085 Simulator", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
      ],
    );
  }
}