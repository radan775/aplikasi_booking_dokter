import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_button.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
import 'package:get/get.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

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
                  AppAssets.imgSignup,
                  width: 200,
                ),
                10.heightBox,
                AppStyles.bold(
                    title: AppStrings.signupNow,
                    size: AppSizes.size18,
                    aligment: TextAlign.center),
              ],
            ),
            40.heightBox,
            Expanded(
                child: Form(
                    child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextfield(hint: AppStrings.fullname),
                  10.heightBox,
                  CustomTextfield(hint: AppStrings.email),
                  10.heightBox,
                  CustomTextfield(hint: AppStrings.password),
                  20.heightBox,
                  CustomButton(
                    buttonText: AppStrings.signup,
                    onTap: () {
                      print("SIGNUP DITEKAN");
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppStyles.normal(title: AppStrings.alreadyHaveAccount),
                      8.widthBox,
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: AppStyles.bold(title: AppStrings.login),
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
