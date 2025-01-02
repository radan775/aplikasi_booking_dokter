import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controllers untuk TextField
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Loading status
  var isLoading = false.obs;

  // Fungsi untuk mendaftarkan pengguna
  Future<void> signup() async {
    if (isLoading.value) return; // Prevent duplicate requests

    try {
      isLoading.value = true; // Tampilkan loading
      // Mendapatkan nilai dari TextField
      final fullname = fullnameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (fullname.isEmpty || email.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'All fields are required!',
            snackPosition: SnackPosition.TOP);
        return;
      }

      // Mendaftarkan pengguna di Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user!.uid;

      // Menyimpan data pengguna di Firestore
      await _firestore.collection('users').doc(userId).set({
        'namalengkap': fullname,
        'email': email,
        'umur': '',
        'nomorhp': '',
        'role': 'user',
      });

      // Membuat sub-koleksi `history` kosong
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('history')
          .doc('placeholder')
          .set({});

      Get.snackbar('Success', 'Account created successfully!',
          snackPosition: SnackPosition.TOP);

      // Navigasi ke halaman lain atau reset form
      clearForm();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false; // Sembunyikan loading
    }
  }

  // Membersihkan form
  void clearForm() {
    fullnameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
