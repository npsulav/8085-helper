import 'package:flutter/material.dart';

import '../res/app_theme.dart';

Widget sevenSegmentDisplay(height, width) {
  return Stack(
    children: [
      Container(
        margin: EdgeInsets.symmetric(
            horizontal: 0.05 * width, vertical: 0.02 * height),
        padding: EdgeInsets.symmetric(
            horizontal: 0.05 * width, vertical: 0.02 * height),
        decoration: const BoxDecoration(color: Color(0xff970101)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "2",
              style: bitDisplay(),
            ),
            Text(
              "0",
              style: bitDisplay(),
            ),
            Text(
              "0",
              style: bitDisplay(),
            ),
            Text(
              "0",
              style: bitDisplay(),
            ),
            Text(
              "E",
              style: bitDisplay(),
            ),
            Text(
              "F",
              style: bitDisplay(),
            ),
          ],
        ),
      ),
      Positioned(
          top: 0,
          right: 0.07 * width,
          bottom: 0,
          child: const CircleAvatar(
            radius: 10,
            backgroundImage: AssetImage("assets/screw.png"),
          )),
      Positioned(
          top: 0,
          left: 0.07 * width,
          bottom: 0,
          child: const CircleAvatar(
            radius: 10,
            backgroundImage: AssetImage("assets/screw.png"),
          )),
    ],
  );
}

Widget button({label,black = false,context}) {
  return Expanded(
    child: Container(
      color: black ? Colors.black: Colors.red,
      margin: const EdgeInsets.all(2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: Feedback.wrapForTap(() { }, context),
          child: Container(
            height: 50,
            alignment: Alignment.center,
              child: Text(
            label.toString().toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          )),
        ),
      ),
    ),
  );
}
