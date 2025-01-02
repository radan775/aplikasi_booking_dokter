import 'package:aplikasi_booking_dokter/app/modules/forget_password/controllers/forget_password_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_button.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.imgLogin, // Gambar yang sama dengan LoginView
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  AppStyles.bold(
                    title: AppStrings.resetYourPassword,
                    size: AppSizes.size24,
                    aligment: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  AppStyles.normal(
                    title: AppStrings.enterYourEmail,
                    size: AppSizes.size16,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Form(
                child: Column(
                  children: [
                    CustomTextfield(
                      hint: AppStrings.email,
                      icon: Icons.email,
                      textController: controller.emailController,
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      return controller.isCodeSent.value
                          ? const SizedBox.shrink()
                          : CustomButton(
                              buttonText: AppStrings.sendResetCode,
                              onTap: () {
                                controller.sendResetCode();
                                controller.startCountdown();
                              },
                              buttonColor: AppColors.blueColor,
                              textColor: Colors.white,
                              borderRadius: 12,
                            );
                    }),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (controller.isCodeSent.value) {
                        return Column(
                          children: [
                            CustomTextfield(
                              hint: AppStrings.enterVerificationCode,
                              icon: Icons.lock,
                              textController: controller.codeController,
                              inputType: TextInputType.number,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Kirim ulang dalam: ${controller.timerDisplay.value}',
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              buttonText: AppStrings.resetPassword,
                              onTap: () {
                                print("RESET DITEKAN");
                              },
                              buttonColor: AppColors.blueColor,
                              textColor: Colors.white,
                              borderRadius: 12,
                            ),
                            const SizedBox(height: 20),
                            if (controller.isTimerExpired.value)
                              CustomButton(
                                buttonText: AppStrings.resendCode,
                                onTap: controller.resendCode,
                                buttonColor: AppColors.yellowColor,
                                textColor: Colors.black,
                                borderRadius: 12,
                              ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(
                          title: AppStrings.rememberedYourPassword,
                          size: AppSizes.size14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: AppStyles.bold(
                            title: AppStrings.login,
                            size: AppSizes.size14,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
