import 'package:aplikasi_booking_dokter/app/data/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.buttonColor = AppColors.primaryColor,
    this.textColor = AppColors.bgColor,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth - 60,
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onTap,
        child: buttonText.text.color(textColor).make(),
      ),
    );
  }
}
