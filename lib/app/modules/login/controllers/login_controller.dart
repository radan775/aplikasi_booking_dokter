import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _storage = GetStorage();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> login() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'All fields are required!',
            snackPosition: SnackPosition.TOP);
        return;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user!.uid;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        Get.snackbar('Error', 'User data not found!',
            snackPosition: SnackPosition.TOP);
        return;
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      final userRole = userData['role'] ?? 'user';

      // Simpan data pengguna di local storage
      _storage.write('userId', userId);
      _storage.write('role', userRole);
      _storage.write('isLogin', true);

      Get.snackbar('Success', 'Login successful!',
          snackPosition: SnackPosition.TOP);

      Get.offAllNamed(Routes.BOTTOM_NAVBAR);
    } on FirebaseAuthException catch (e) {
      // Penanganan error spesifik
      switch (e.code) {
        case 'invalid-email':
        case 'user-not-found':
        case 'wrong-password':
          Get.snackbar('Error', 'Akun tidak terdaftar',
              snackPosition: SnackPosition.TOP);
          break;
        default:
          Get.snackbar('Error', 'Akun tidak terdaftar',
              snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Error', 'Kesalahan tidak terduga terjadi.',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
