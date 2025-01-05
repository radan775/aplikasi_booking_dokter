import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/login/controllers/login_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_button.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: AppSizes.marginTop120),
          padding:
              EdgeInsets.symmetric(horizontal: AppSizes.paddingHorizontal16),
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
                    title: AppStrings.welcomeBack,
                    size: AppSizes.fontSize24,
                  ),
                  SizedBox(height: AppSizes.heightSizeBox10),
                  AppStyles.normal(
                    title: AppStrings.weAreExcited,
                    size: AppSizes.fontSize16,
                    color: AppColors.greyColor,
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
                    CustomTextfield(
                      hint: AppStrings.password,
                      icon: Icons.lock,
                      obscureText: true,
                      textController: controller.passwordController,
                    ),
                    SizedBox(height: AppSizes.heightSizeBox10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Tambahkan logika untuk mengarahkan ke halaman lupa password
                          Get.toNamed(Routes.FORGET_PASSWORD);
                        },
                        child: Text(
                          "Lupa Password?",
                          style: TextStyle(
                            fontSize: AppSizes.fontSize14,
                            color: AppColors.redColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.heightSizeBox30),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return SizedBox(
                          width: AppSizes.loadingSize,
                          height: AppSizes.loadingSize,
                          child: CircularProgressIndicator(
                            strokeWidth: AppSizes.strokeWidth3,
                          ),
                        );
                      }
                      return CustomButton(
                        buttonText: AppStrings.login,
                        onTap: controller.login,
                        buttonColor: AppColors.blueColor,
                        textColor: AppColors.whiteColor,
                        borderRadius: AppSizes.borderRadius12,
                        fontSize: AppSizes.fontSize16,
                      );
                    }),
                    SizedBox(height: AppSizes.heightSizeBox20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(
                          title: AppStrings.dontHaveAccount,
                          size: AppSizes.fontSize14,
                          color: AppColors.greyColor,
                        ),
                        SizedBox(width: AppSizes.widthSizeBox8),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.SIGNUP);
                          },
                          child: AppStyles.bold(
                            title: AppStrings.signup,
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
