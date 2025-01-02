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
    final controller = Get.put(LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 120),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.imgLogin,
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  AppStyles.bold(
                    title: AppStrings.welcomeBack,
                    size: AppSizes.size24,
                  ),
                  const SizedBox(height: 10),
                  AppStyles.normal(
                    title: AppStrings.weAreExcited,
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
                    CustomTextfield(
                      hint: AppStrings.password,
                      icon: Icons.lock,
                      obscureText: true,
                      textController: controller.passwordController,
                    ),
                    const SizedBox(height: 30),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const CircularProgressIndicator();
                      }
                      return CustomButton(
                        buttonText: AppStrings.login,
                        onTap: controller.login,
                        buttonColor: AppColors.blueColor,
                        textColor: Colors.white,
                        borderRadius: 12,
                      );
                    }),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(
                          title: AppStrings.dontHaveAccount,
                          size: AppSizes.size14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.SIGNUP);
                          },
                          child: AppStyles.bold(
                            title: AppStrings.signup,
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
