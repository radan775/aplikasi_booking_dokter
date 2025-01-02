import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/signup/controllers/signup_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_button.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

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
                    AppAssets.imgSignup,
                    width: 200,
                  ),
                  AppStyles.bold(
                    title: AppStrings.signupNow,
                    size: AppSizes.size24,
                    aligment: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  AppStyles.normal(
                    title: AppStrings.createAccount,
                    size: AppSizes.size16,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Form(
                child: Column(
                  children: [
                    CustomTextfield(
                      hint: AppStrings.fullname,
                      icon: Icons.person,
                      textController: controller.fullnameController,
                    ),
                    const SizedBox(height: 20),
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
                        buttonText: AppStrings.signup,
                        onTap: controller.signup,
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
                          title: AppStrings.alreadyHaveAccount,
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
