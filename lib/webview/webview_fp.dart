
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';


/// [FullPageWebView] is a Web View Screen of the app,
/// contains `copy link` options as a menu item
///
/// [urlData] is the String Url to be initially opened in WebView
class FullPageWebView extends StatefulWidget {
  final String urlData;

  const FullPageWebView({Key? key, required this.urlData}) : super(key: key);

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class Constants {
  static const String fund = 'Copy Link';
  static const List<String> choices = <String>[fund];
}

class _CustomWebViewState extends State<FullPageWebView> {
  /// for displaying progress of WebView loading
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        actions: [
          PopupMenuButton<String>(
            onSelected: (d) {
              // copies the current webview url to Clipboard
              // needs switch-checks if the Constants.choices.length > 1
              Clipboard.setData(ClipboardData(text: widget.urlData));
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Copied to clipboard!")));
            },
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            minHeight: 3,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            value: progress.toDouble() / 100,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: const Icon(Icons.arrow_back)),
        title: Text(
          widget.urlData.toString(),
          style: GoogleFonts.poppins(fontSize: 12),
        ),
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: WebView(
          onProgress: (progress) {
            setState(() {
              this.progress = progress;
            });
          },
          initialUrl: widget.urlData.toString(),
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
