import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final titleController = TextEditingController();
  final linkController = TextEditingController();
  final imageUrlController = TextEditingController();
  RxString imageUrl = ''.obs;
  RxBool isLoading = false.obs;

  void updateImageUrl(String value) {
    imageUrl.value = value;
  }

  bool isValidImageUrl(String url) {
    final urlPattern = r'^(https?:\/\/).*\.(jpg|jpeg|png|gif|bmp|webp)$';
    final regex = RegExp(urlPattern, caseSensitive: false);
    return regex.hasMatch(url);
  }

  Future<void> uploadNews() async {
    // Validasi input
    if (titleController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Judul berita harus diisi',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (imageUrlController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'URL gambar berita harus diisi',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    // Validasi format URL gambar
    if (!isValidImageUrl(imageUrlController.text)) {
      Get.snackbar(
        'Error',
        'URL gambar tidak valid. Gunakan URL yang berakhir dengan .jpg, .png, dll.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // Set loading state sebelum proses
      isLoading.value = true;

      // Tambahkan delay untuk simulasi proses
      await Future.delayed(const Duration(seconds: 2));

      // Proses upload
      await _firestore.collection('news').add({
        'title': titleController.text,
        'imageUrl': imageUrlController.text,
        'link': linkController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Reset Form
      titleController.clear();
      linkController.clear();
      imageUrlController.clear();
      imageUrl.value = '';

      // Kembali ke halaman sebelumnya
      Get.back(result: true);

      // Tampilkan snackbar sukses
      Get.snackbar(
        'Sukses',
        'Berita berhasil ditambahkan',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      // Tampilkan error
      Get.snackbar(
        'Error',
        'Gagal mengunggah berita: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      // Pastikan loading state dimatikan
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    linkController.dispose();
    imageUrlController.dispose(); // Dispose controller baru
    super.onClose();
  }
}
