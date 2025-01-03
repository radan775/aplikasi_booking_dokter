import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  RxBool isFormValid = false.obs;

  Future<void> changePassword() async {
    validateForm();
    if (!isFormValid.value) {
      showMissingFieldsSnackbar();
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Error",
        "Password baru dan konfirmasi password tidak cocok.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("Tidak ada pengguna yang login");
      }

      // Reauthenticate user with old password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPasswordController.text,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPasswordController.text);

      Get.back();

      Get.snackbar(
        "Sukses",
        "Password berhasil diubah.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
      );

      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal mengubah password: ${e.toString()}",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void validateForm() {
    bool isOldPasswordFilled = oldPasswordController.text.trim().isNotEmpty;
    bool isNewPasswordFilled = newPasswordController.text.trim().isNotEmpty;
    bool isConfirmPasswordFilled =
        confirmPasswordController.text.trim().isNotEmpty;

    isFormValid.value =
        isOldPasswordFilled && isNewPasswordFilled && isConfirmPasswordFilled;
  }

  void showMissingFieldsSnackbar() {
    List<String> missingFields = [];

    if (oldPasswordController.text.trim().isEmpty)
      missingFields.add('Password Lama');
    if (newPasswordController.text.trim().isEmpty)
      missingFields.add('Password Baru');
    if (confirmPasswordController.text.trim().isEmpty)
      missingFields.add('Konfirmasi Password Baru');

    String missingFieldsText = missingFields.join(', ');

    Get.snackbar(
      'Peringatan',
      'Harap lengkapi field berikut: $missingFieldsText',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.warning, color: Colors.white),
    );
  }
}
