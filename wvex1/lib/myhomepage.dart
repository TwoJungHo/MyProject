import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://flutter.dev";
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: <PlaybackMediaTypes>{},
      );
    } else {
      params = PlatformWebViewControllerCreationParams();
    }

    final WebViewController con =
        WebViewController.fromPlatformCreationParams(params);

    con
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(onProgress: (int progress) {
        print(progress);
      }, onPageStarted: (String url) {
        print(url);
      }, onPageFinished: (String url) {
        print(url);
      }, onWebResourceError: (WebResourceError error) {
        print("""${error.description}""");
      }, onNavigationRequest: (NavigationRequest request) {
        print(request.url);
        return NavigationDecision.navigate;
      }))
      ..addJavaScriptChannel(
        "Toaster",
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
    ..loadRequest(Uri.parse(url));

    if(con.platform is AndroidWebViewController){
      AndroidWebViewController.enableDebugging(true);
      (con.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }

    controller = con;
    // controller = WebViewController()
    // ..loadRequest(Uri.parse(url)); //위에 controller를 이렇게씀
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView test"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
