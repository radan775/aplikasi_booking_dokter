import 'package:aplikasi_booking_dokter/app/data/consts/colors.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/fonts.dart';
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
        backgroundColor: AppColors.blueColor, // Menggunakan AppColors
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor, // Menggunakan AppColors
            size: AppSizes.iconSize28,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Webview Berita',
          style: TextStyle(
            color: AppColors.whiteColor, // Menggunakan AppColors
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: controller.webViewController(),
      ),
    );
  }
}
