import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChangePasswordController extends GetxController {
  // TextEditingControllers untuk input field
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Loading state
  var isLoading = false.obs;

  // Fungsi untuk mengubah password
  Future<void> changePassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Error",
        "Password baru dan konfirmasi password tidak cocok.",
        snackPosition: SnackPosition.TOP, // Mengubah ke TOP
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      // Simulasi proses ubah password
      await Future.delayed(const Duration(seconds: 2));

      // Sukses
      Get.snackbar(
        "Sukses",
        "Password berhasil diubah.",
        snackPosition: SnackPosition.TOP, // Mengubah ke TOP
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Reset input field
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal mengubah password.",
        snackPosition: SnackPosition.TOP, // Mengubah ke TOP
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
