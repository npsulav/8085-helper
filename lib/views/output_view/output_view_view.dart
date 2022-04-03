/// Generated by Flutter GetX Starter on 2022-04-03 19:34
import 'package:a_8085_helper/assembler/assembler.dart';
import 'package:creamy_field/creamy_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/app_colors.dart';
import 'output_view_logic.dart';

class OutputViewView extends StatelessWidget {


  String code;

   OutputViewView({Key? key, required this.code}) : super(key: key);

  final OutputViewLogic logic = Get.put(OutputViewLogic());
  Assembler assembler = Assembler();

  late CreamyEditingController controller;

  late ScrollController scrollController;

  final PageController pageController = PageController();

  String compiledCode = "";

  int pageIndex = 0;


  @override
  Widget build(BuildContext context) {




    controller = CreamyEditingController(
      // This is the CreamySyntaxHighlighter which will be used by the controller
      // to generate list of RichText for syntax highlighting
        syntaxHighlighter: CreamySyntaxHighlighter(
          language: LanguageType.x86asm,
          theme: HighlightedThemeType.githubTheme,
        ),

        // The number of spaces which will replace `\t`.
        // Setting this to 1 does nothing & setting this to value less than 1
        // throws assertion error.
        tabSize: 4,
        text: code);
    scrollController = ScrollController();

    return LineCountIndicator(
      textControllerOfTextField: controller,
      scrollControllerOfTextField: scrollController,
      decoration: LineCountIndicatorDecoration(
          backgroundColor: Colors.grey,
          rightBorderSide: const BorderSide(color: AppColors.primary)),
      // Allow this Text field to be horizontally scrollable
      child: HorizontalScrollable(
        // Additional options for text selection widget
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextField(
            autofocus: false,
            // Our controller should be up casted as CreamyEditingController
            // Note: Declare controller as CreamyEditingController if this fails.
            controller: controller,
            scrollController: scrollController,
            textCapitalization: TextCapitalization.none,
            decoration: const InputDecoration.collapsed(
                hintText: 'Write .asm codes here'),
            maxLines: null,
          ),
        ),
      ),
    );
  }
}
