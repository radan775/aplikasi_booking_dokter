import 'package:aplikasi_booking_dokter/app/data/consts/colors.dart';
import 'package:aplikasi_booking_dokter/app/modules/ini_webview/controllers/ini_webview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IniWebviewView extends GetView<IniWebViewController> {
  const IniWebviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Web View"),
        backgroundColor: AppColors.blueColor,
      ),
      body: WebViewWidget(
        controller: controller.webViewController(),
      ),
    );
  }
}
