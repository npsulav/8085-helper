/// Generated by Flutter GetX Starter on 2022-04-03 18:58
import 'package:a_8085_helper/components/seven-segment-display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'refrence_screen_logic.dart';

class SimulatorScreenView extends StatefulWidget {

  SimulatorScreenView({Key? key}) : super(key: key);

  @override
  State<SimulatorScreenView> createState() => _SimulatorScreenViewState();
}

class _SimulatorScreenViewState extends State<SimulatorScreenView> {
  final RefrenceScreenLogic logic = Get.put(RefrenceScreenLogic());

  @override
  Widget build(BuildContext context) {

    bool fullScreen = false;

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg8085.jpg"), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  if(fullScreen) {
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                  }
                  else {
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                  }
                  fullScreen = !fullScreen;

                },
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child:  CircleAvatar(
                    backgroundColor: Colors.white,
                      radius: 20, child: Icon(fullScreen ? CupertinoIcons.fullscreen: CupertinoIcons.fullscreen_exit)),
                ),
              ),
            ],
          ),
          sevenSegmentDisplay(context.height, context.width),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    button(label: "Reset", context: context),
                    button(label: "VCT\nINT", context: context),
                    button(label: "SHIFT", context: context),
                    button(label: "C", black: true, context: context),
                    button(label: "D", black: true, context: context),
                    button(label: "E", black: true, context: context),
                    button(label: "F", black: true, context: context),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    button(label: "EXREG\nSI", context: context),
                    button(label: "INS\nDATA", context: context),
                    button(label: "DEL\nDATA", context: context),
                    button(label: "8\nH", black: true, context: context),
                    button(label: "9\nL", black: true, context: context),
                    button(label: "A", black: true, context: context),
                    button(label: "B", black: true, context: context),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    button(label: "DEL\nGO", context: context),
                    button(label: "INS\nBM", context: context),
                    button(label: "REL\nEXMEM", context: context),
                    button(label: "4\nPCH", black: true, context: context),
                    button(label: "5\nPCL", black: true, context: context),
                    button(label: "6\nSPH", black: true, context: context),
                    button(label: "7\nSPL", black: true, context: context),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    button(label: "STRING\nPRE", context: context),
                    button(label: "MEMC\nNEXT", context: context),
                    button(label: "FILL", context: context),
                    button(label: "0", black: true, context: context),
                    button(label: "1\nTTY", black: true, context: context),
                    button(label: "2\nCRT", black: true, context: context),
                    button(label: "3\nI", black: true, context: context),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
