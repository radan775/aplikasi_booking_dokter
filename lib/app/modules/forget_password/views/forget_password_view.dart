// Import untuk Timer
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
      body: Container(
        margin: EdgeInsets.only(top: 120),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.imgLogin, // Gambar yang sama dengan LoginView
                  width: 200,
                ),
                10.heightBox,
                AppStyles.bold(
                  title: AppStrings.resetYourPassword,
                  size: AppSizes.size18,
                ),
                AppStyles.bold(title: AppStrings.enterYourEmail),
              ],
            ),
            40.heightBox,
            Expanded(
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // TextField untuk memasukkan email
                      CustomTextfield(
                        hint: AppStrings.email,
                        textController: controller.emailController,
                      ),
                      SizedBox(height: 10),
                      // Tombol untuk mengirim reset code
                      Obx(() {
                        return controller.isCodeSent.value
                            ? SizedBox
                                .shrink() // Tombol kirim kode menghilang jika kode sudah dikirim
                            : CustomButton(
                                buttonText: AppStrings.sendResetCode,
                                onTap: () {
                                  // Logika untuk mengirim reset link atau kode
                                  controller.sendResetCode();
                                  controller.startCountdown();
                                },
                              );
                      }),
                      SizedBox(height: 10),
                      Obx(() {
                        if (controller.isCodeSent.value) {
                          return Column(
                            children: [
                              // Form untuk input kode verifikasi
                              CustomTextfield(
                                hint: AppStrings.enterVerificationCode,
                                textController: controller.codeController,
                                inputType: TextInputType.number,
                              ),
                              SizedBox(height: 10),
                              // Timer countdown untuk 60 detik
                              Text(
                                'Kirim ulang dalam: ${controller.timerDisplay.value}',
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(height: 5),
                              CustomButton(
                                buttonText: AppStrings.resetPassword,
                                onTap: () {
                                  print("RESET DITEKAN");
                                },
                              ),
                              SizedBox(height: 10),
                              // Tombol resend code setelah waktu habis
                              if (controller.isTimerExpired.value)
                                CustomButton(
                                  buttonText: AppStrings.resendCode,
                                  onTap: controller.resendCode,
                                ),
                            ],
                          );
                        }
                        return SizedBox.shrink();
                      }),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppStyles.normal(
                              title: AppStrings.rememberedYourPassword),
                          8.widthBox,
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: AppStyles.bold(title: AppStrings.login),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
