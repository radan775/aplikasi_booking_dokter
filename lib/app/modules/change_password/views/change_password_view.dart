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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: AppSizes.iconSize28,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Ubah Password',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Silakan ubah password Anda dengan mengisi form di bawah ini:",
              style: TextStyle(
                fontSize: AppSizes.fontSize14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox20),

            // Old Password Field
            CustomTextfield(
              hint: "Password Lama",
              textController: controller.oldPasswordController,
              textColor: Colors.black,
              borderColor: AppColors.blueColor,
              obscureText: true,
              icon: Icons.lock,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),

            // New Password Field
            CustomTextfield(
              hint: "Password Baru",
              textController: controller.newPasswordController,
              textColor: Colors.black,
              borderColor: AppColors.blueColor,
              obscureText: true,
              icon: Icons.lock_open,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),

            // Confirm Password Field
            CustomTextfield(
              hint: "Konfirmasi Password Baru",
              textController: controller.confirmPasswordController,
              textColor: Colors.black,
              borderColor: AppColors.blueColor,
              obscureText: true,
              icon: Icons.check,
            ),
            SizedBox(height: AppSizes.heightSizeBox40),

            Center(
              child: Obx(
                () => SizedBox(
                  width: AppSizes.widthContainer330,
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
                                      fontSize: AppSizes.fontSize18,
                                    ),
                                  ),
                                  content: Text(
                                    'Apakah Anda yakin ingin mengubah password?',
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: AppSizes.fontSize12,
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
                                          fontSize: AppSizes.fontSize14,
                                        ),
                                      ),
                                    ),
                                    // Tombol Yakin
                                    ElevatedButton(
                                      onPressed: () {
                                        // Tutup dialog
                                        Navigator.of(context).pop();

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
                                          fontSize: AppSizes.fontSize14,
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
                      padding: EdgeInsets.symmetric(
                          vertical: AppSizes.paddingVertical12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius8,
                        ),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Ubah Password",
                            style: TextStyle(
                              fontSize: AppSizes.fontSize16,
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
