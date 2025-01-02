import 'package:aplikasi_booking_dokter/app/modules/ini_webview/controllers/ini_webview_controller.dart';
import 'package:get/get.dart';

class IniWebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IniWebViewController>(
      () => IniWebViewController(),
    );
  }
}
