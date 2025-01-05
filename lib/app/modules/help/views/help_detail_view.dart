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
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor, // Ganti dengan AppColors
            size: AppSizes.iconSize28,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          helpTitle,
          style: TextStyle(
            color: AppColors.whiteColor, // Ganti dengan AppColors
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Text(
          "Informasi detail untuk kategori \"$helpTitle\" akan ditampilkan di sini.",
          style: TextStyle(
            fontSize: AppSizes.fontSize14,
            color: AppColors.greyColor, // Ganti dengan AppColors
          ),
        ),
      ),
    );
  }
}
