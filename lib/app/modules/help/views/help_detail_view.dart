import 'package:aplikasi_booking_dokter/app/data/consts/colors.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpDetailView extends StatelessWidget {
  const HelpDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final String helpTitle = Get.arguments ?? "Detail Bantuan";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: Text(
          helpTitle,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Text(
          "Informasi detail untuk kategori \"$helpTitle\" akan ditampilkan di sini.",
          style: TextStyle(
            fontSize: AppSizes.fontSize14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
