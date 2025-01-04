import 'package:aplikasi_booking_dokter/app/modules/forget_password/controllers/forget_password_controller.dart';
import 'package:get/get.dart';
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
          margin: EdgeInsets.only(
            top: AppSizes.marginTop100,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingHorizontal16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.imgLogin,
                    width: AppSizes.imageWidth200,
                  ),
                  SizedBox(height: AppSizes.heightSizeBox20),
                  AppStyles.bold(
                    title: AppStrings.resetYourPassword,
                    size: AppSizes.fontSize24,
                    aligment: TextAlign.center,
                  ),
                  SizedBox(height: AppSizes.heightSizeBox10),
                  AppStyles.normal(
                    title: AppStrings.enterYourEmail,
                    size: AppSizes.fontSize16,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.heightSizeBox40),
              Form(
                child: Column(
                  children: [
                    CustomTextfield(
                      hint: AppStrings.email,
                      icon: Icons.email,
                      textController: controller.emailController,
                    ),
                    SizedBox(height: AppSizes.heightSizeBox20),
                    Obx(() {
                      return controller.isCodeSent.value
                          ? SizedBox.shrink()
                          : CustomButton(
                              buttonText: AppStrings.sendResetCode,
                              onTap: () {
                                controller.sendResetCode();
                                controller.startCountdown();
                              },
                              buttonColor: AppColors.blueColor,
                              textColor: Colors.white,
                              borderRadius: AppSizes.borderRadius12,
                            );
                    }),
                    SizedBox(height: AppSizes.heightSizeBox20),
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
                            SizedBox(height: AppSizes.heightSizeBox20),
                            Text(
                              'Kirim ulang dalam: ${controller.timerDisplay.value}',
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: AppSizes.heightSizeBox10),
                            CustomButton(
                              buttonText: AppStrings.resetPassword,
                              onTap: () {
                                print("RESET DITEKAN");
                              },
                              buttonColor: AppColors.blueColor,
                              textColor: Colors.white,
                              borderRadius: AppSizes.borderRadius12,
                            ),
                            SizedBox(height: AppSizes.heightSizeBox20),
                            if (controller.isTimerExpired.value)
                              CustomButton(
                                buttonText: AppStrings.resendCode,
                                onTap: controller.resendCode,
                                buttonColor: AppColors.yellowColor,
                                textColor: Colors.black,
                                borderRadius: AppSizes.borderRadius12,
                              ),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    }),
                    SizedBox(height: AppSizes.heightSizeBox20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(
                          title: AppStrings.rememberedYourPassword,
                          size: AppSizes.fontSize14,
                          color: Colors.grey,
                        ),
                        SizedBox(width: AppSizes.widthSizeBox8),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: AppStyles.bold(
                            title: AppStrings.login,
                            size: AppSizes.fontSize14,
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
