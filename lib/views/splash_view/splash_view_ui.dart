import 'package:a_8085_helper/res/app_strings.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashViewView extends StatefulWidget {
  const SplashViewView({Key? key}) : super(key: key);

  @override
  State<SplashViewView> createState() => _SplashViewViewState();
}

class _SplashViewViewState extends State<SplashViewView> {

  @override
  void initState() {
    /// create a Timer for navigating to another screen
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAndToNamed("/home");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: context.width,
      height: context.height,
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withAlpha(30), BlendMode.dstATop),
        image: const AssetImage("assets/bg.jpg"),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: context.width * 0.12,
            backgroundImage: const AssetImage("assets/images.png"),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child:
              // AnimatedTextKit(
              //   animatedTexts: [
              //     TypewriterAnimatedText(
              //       AppStrings.appName.toUpperCase(),
              //       speed: const Duration(milliseconds: 150),
              //       textStyle: TextStyle(
              //           fontSize: 0.054 * context.width, fontWeight: FontWeight.bold),),
              //   ],
              //   displayFullTextOnTap: true,
              //   stopPauseOnTap: true,
              // )
              Text(AppStrings.appName.toUpperCase(),
                  style: TextStyle(
                      fontSize: 0.054 * context.width,
                      fontWeight: FontWeight.bold)),
          )
        ],
      ),
    ));
  }
}
