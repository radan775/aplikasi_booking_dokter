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
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            // Tampilkan dialog konfirmasi
                            showDialog(
                              context: Get.context!,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Konfirmasi Ubah Password',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                  content: Text(
                                    'Apakah Anda yakin ingin mengubah password?',
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  actions: [
                                    // Tombol Batal
                                    TextButton(
                                      onPressed: () {
                                        // Tutup dialog
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Batal',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Tombol Yakin
                                    ElevatedButton(
                                      onPressed: () {
                                        // Tutup dialog
                                        Navigator.of(context).pop();

                                        // Panggil method change password
                                        controller.changePassword();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.blueColor,
                                      ),
                                      child: Text(
                                        'Yakin',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
