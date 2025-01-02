import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChangeProfileController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final birthDateController = TextEditingController();
  final genderController = TextEditingController();
  final cityController = TextEditingController();
  final ktpController = TextEditingController();
  final addressController = TextEditingController();

  var selectedGender = ''.obs;

  void updateProfile() {
    // Logika untuk memperbarui profil
    Get.snackbar("Sukses", "Profil berhasil diperbarui!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }
}
