import 'dart:io';

import 'package:aplikasi_booking_dokter/app/data/consts/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _storage = GetStorage();
  final ImagePicker _picker = ImagePicker();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final birthDateController = TextEditingController();
  final genderController = TextEditingController();

  var selectedGender = ''.obs;
  var isLoading = false.obs;
  RxBool isFormValid = false.obs;
  Rx<File?> profileImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUserData();

    loadProfileImage();
  }

  void showImageSourceDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Pilih Sumber Foto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Kamera'),
              onTap: () {
                Get.back(); // Tutup dialog
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Galeri'),
              onTap: () {
                Get.back(); // Tutup dialog
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        // Simpan file
        File imageFile = File(pickedFile.path);
        profileImage.value = imageFile;
      }
    } catch (e) {
      // Tangani error
      Get.snackbar(
        'Error',
        'Gagal mengambil foto: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void loadProfileImage() {
    String? imagePath = _storage.read('fotoProfile');
    if (imagePath != null) {
      profileImage.value = File(imagePath);
    }
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      String? userId = _storage.read('userId');
      if (userId == null) {
        print('User ID tidak ditemukan');
        return;
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        nameController.text = userData['namalengkap'] ?? '';
        phoneController.text = userData['nomorhp'] ?? '';
        emailController.text = userData['email'] ?? '';
        ageController.text = userData['umur']?.toString() ?? '';
        birthDateController.text = userData['tanggalLahir'] ?? '';
        selectedGender.value = userData['jenisKelamin'] ?? '';
      }
    } catch (e) {
      print('Error fetching user data: $e');
      Get.snackbar(
        'Error',
        'Gagal mengambil data profil',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void updateProfile() async {
    validateForm();
    if (!isFormValid.value) {
      showMissingFieldsSnackbar();
      return;
    }

    try {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            color: AppColors.blueColor,
          ),
        ),
        barrierDismissible: false,
      );

      await Future.delayed(const Duration(seconds: 2));
      String? userId = _storage.read('userId');
      if (userId == null) {
        Get.back();

        Get.snackbar(
          'Error',
          'User ID tidak ditemukan',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      Map<String, dynamic> updateData = {
        'namalengkap': nameController.text.trim(),
        'nomorhp': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'umur': int.tryParse(ageController.text.trim()) ?? 0,
        'tanggalLahir': birthDateController.text.trim(),
        'jenisKelamin': selectedGender.value,
      };

      await _firestore.collection('users').doc(userId).update(updateData);
      _storage.write('fotoProfile', profileImage.value?.path);
      // Tutup loading
      Get.back();
      // Kembali ke halaman sebelumnya
      Get.back(result: true);
      // Tampilkan snackbar sukses
      Get.snackbar(
        "Sukses",
        "Profil berhasil diperbarui!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
      );
    } catch (e) {
      // Tutup loading jika terjadi error
      Get.back();

      print('Error updating profile: $e');
      Get.snackbar(
        'Error',
        'Gagal memperbarui profil',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void validateForm() {
    bool isNameFilled = nameController.text.trim().isNotEmpty;
    bool isPhoneFilled = phoneController.text.trim().isNotEmpty;
    bool isEmailFilled = emailController.text.trim().isNotEmpty;
    bool isAgeFilled = ageController.text.trim().isNotEmpty;
    bool isBirthDateFilled = birthDateController.text.trim().isNotEmpty;
    bool isGenderSelected = selectedGender.value.isNotEmpty;

    isFormValid.value = isNameFilled &&
        isPhoneFilled &&
        isEmailFilled &&
        isAgeFilled &&
        isBirthDateFilled &&
        isGenderSelected;
  }

  void showMissingFieldsSnackbar() {
    List<String> missingFields = [];

    if (nameController.text.trim().isEmpty) missingFields.add('Nama Lengkap');
    if (phoneController.text.trim().isEmpty) missingFields.add('Nomor HP');
    if (emailController.text.trim().isEmpty) missingFields.add('Email');
    if (ageController.text.trim().isEmpty) missingFields.add('Umur');
    if (birthDateController.text.trim().isEmpty) {
      missingFields.add('Tanggal Lahir');
    }
    if (selectedGender.value.isEmpty) missingFields.add('Jenis Kelamin');

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
