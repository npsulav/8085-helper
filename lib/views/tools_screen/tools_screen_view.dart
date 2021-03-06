/// Generated by Flutter GetX Starter on 2022-04-03 20:10
import 'dart:collection';
import 'dart:developer';

import 'package:a_8085_helper/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assembler/assembler.dart';
import 'tools_screen_logic.dart';

class ToolsScreenView extends StatefulWidget {
  @override
  State<ToolsScreenView> createState() => _ToolsScreenViewState();
}

class _ToolsScreenViewState extends State<ToolsScreenView> {
  final ToolsScreenLogic logic = Get.put(ToolsScreenLogic());

  Assembler assembler = Assembler();

  late HashMap hm;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    hm = assembler.opcodeMap;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: textEditingController,
            onChanged: (String code) {
              assembler.opcodeMap.forEach((key, value) {
                if(!key.toString().contains(code)) {
                  hm.remove(key);
                } else {

                }
                setState(() {

                });
              });
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Search here",
                fillColor: Colors.white70),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: hm.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  hm.keys.elementAt(index),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  hm.values.elementAt(index),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text((index + 1).toString()),
              );
            },
          ),
        ),
      ],
    );
  }
}
