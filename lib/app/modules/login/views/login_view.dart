import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/home/views/home.dart';
import 'package:aplikasi_booking_dokter/app/modules/home/views/home_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/signup/views/signup_view.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_button.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                  AppAssets.imgLogin,
                  width: 200,
                ),
                10.heightBox,
                AppStyles.bold(
                    title: AppStrings.welcomeBack, size: AppSizes.size18),
                AppStyles.bold(title: AppStrings.weAreExcited),
              ],
            ),
            40.heightBox,
            Expanded(
                child: Form(
                    child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextfield(hint: AppStrings.email),
                  SizedBox(height: 10),
                  CustomTextfield(hint: AppStrings.password),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppStyles.normal(title: AppStrings.forgetPassword),
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    buttonText: AppStrings.login,
                    onTap: () {
                      Get.to(() => const Home());
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppStyles.normal(title: AppStrings.dontHaveAccount),
                      8.widthBox,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SignupView());
                        },
                        child: AppStyles.bold(title: AppStrings.signup),
                      ),
                    ],
                  )
                ],
              ),
            ))),
          ],
        ),
      ),
    );
  }
}