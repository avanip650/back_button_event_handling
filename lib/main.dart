import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String url = "https://flutter.dev/";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (_) => Home(),
      },
      title: 'Webview',
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final webView = FlutterWebviewPlugin();
  TextEditingController controller = TextEditingController(text: url);

  @override
  void initState() {
    super.initState();

    webView.close();
    controller.addListener(() {
      url = controller.text;
    });
  }

  @override
  void dispose() {
    webView.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child: WebviewScaffold(
        url: url,
//      appBar: AppBar(
//        title: Text("WebView"),
//        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
//          Navigator.pop(context);
//        }),
//      ),
        withJavascript: true,
        withLocalStorage: true,
        withZoom: true,
      ),
    );
  }
}