import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/change_password/controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: const Text(
          'Ubah Password',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Silakan ubah password Anda dengan mengisi form di bawah ini:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),

            // Old Password Field
            CustomTextfield(
              hint: "Password Lama",
              textController: controller.oldPasswordController,
              textColor: Colors.black,
              borderColor: AppColors.blueColor,
              obscureText: true,
              icon: Icons.lock,
            ),
            const SizedBox(height: 16),

            // New Password Field
            CustomTextfield(
              hint: "Password Baru",
              textController: controller.newPasswordController,
              textColor: Colors.black,
              borderColor: AppColors.blueColor,
              obscureText: true,
              icon: Icons.lock_open,
            ),
            const SizedBox(height: 16),

            // Confirm Password Field
            CustomTextfield(
              hint: "Konfirmasi Password Baru",
              textController: controller.confirmPasswordController,
              textColor: Colors.black,
              borderColor: AppColors.blueColor,
              obscureText: true,
              icon: Icons.check,
            ),
            const SizedBox(height: 40),

            // Submit Button Centered
            Center(
              child: Obx(
                () => SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.8, // Lebar ditambah
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            await controller.changePassword();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12), // Tinggi dikurangi
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Ubah Password",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
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
