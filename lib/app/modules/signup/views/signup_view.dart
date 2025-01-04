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
                    AppAssets.imgSignup,
                    width: AppSizes.imageWidth200,
                  ),
                  AppStyles.bold(
                    title: AppStrings.signupNow,
                    size: AppSizes.fontSize24,
                    aligment: TextAlign.center,
                  ),
                  SizedBox(height: AppSizes.heightSizeBox10),
                  AppStyles.normal(
                    title: AppStrings.createAccount,
                    size: AppSizes.fontSize16,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.heightSizeBox10),
              Form(
                child: Column(
                  children: [
                    CustomTextfield(
                      hint: AppStrings.fullname,
                      icon: Icons.person,
                      textController: controller.fullnameController,
                    ),
                    SizedBox(height: AppSizes.heightSizeBox20),
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
                    SizedBox(height: AppSizes.heightSizeBox30),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return CircularProgressIndicator();
                      }
                      return CustomButton(
                        buttonText: AppStrings.signup,
                        onTap: controller.signup,
                        buttonColor: AppColors.blueColor,
                        textColor: Colors.white,
                        borderRadius: AppSizes.borderRadius12,
                        fontSize: AppSizes.fontSize16,
                      );
                    }),
                    SizedBox(height: AppSizes.heightSizeBox20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(
                          title: AppStrings.alreadyHaveAccount,
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
