import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IniWebViewController extends GetxController {
  String url_webview = "";
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    url_webview = Get.arguments;
  }

  WebViewController webViewController() {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url_webview));
  }
}
