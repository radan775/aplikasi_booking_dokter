import 'package:aplikasi_booking_dokter/app/data/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const CustomButton(
      {super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth - 60,
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.bgColor,
        ),
        onPressed: onTap,
        child: buttonText.text.make(),
      ),
    );
  }
}
