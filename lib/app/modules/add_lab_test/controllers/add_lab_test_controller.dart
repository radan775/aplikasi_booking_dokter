import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddLabTestController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text Controllers
  final hospitalController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  final testController = TextEditingController();
  final priceController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final startHourController = TextEditingController();
  final endHourController = TextEditingController();
  final scheduleStartController = TextEditingController();
  final scheduleEndController = TextEditingController();

  // Schedules
  RxList<Map<String, dynamic>> schedules = <Map<String, dynamic>>[].obs;

  // Loading State
  RxBool isLoading = false.obs;

  // Method untuk menambahkan jadwal
  void addSchedule() {
    // Validasi input jadwal
    if (scheduleStartController.text.isEmpty ||
        scheduleEndController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Waktu mulai dan akhir jadwal harus diisi',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    String type = _determineTimeType(scheduleStartController.text);

    schedules.add({
      'start': scheduleStartController.text,
      'end': scheduleEndController.text,
      'type': type,
    });

    // Bersihkan controller setelah menambahkan
    scheduleStartController.clear();
    scheduleEndController.clear();
  }

  // Hapus jadwal
  void removeSchedule(int index) {
    schedules.removeAt(index);
  }

  // Tentukan tipe waktu
  String _determineTimeType(String startTime) {
    DateTime time = DateFormat('HH:mm').parse(startTime);
    if (time.hour >= 4 && time.hour < 10) {
      return 'Pagi';
    } else if (time.hour >= 10 && time.hour < 14) {
      return 'Siang';
    } else if (time.hour >= 14 && time.hour < 18) {
      return 'Sore';
    } else {
      return 'Malam';
    }
  }

  // Validasi input
  bool validateInput() {
    if (hospitalController.text.isEmpty) {
      Get.snackbar('Error', 'Nama Rumah Sakit harus diisi');
      return false;
    }
    if (addressController.text.isEmpty) {
      Get.snackbar('Error', 'Alamat harus diisi');
      return false;
    }
    if (cityController.text.isEmpty) {
      Get.snackbar('Error', 'Kota harus diisi');
      return false;
    }
    if (districtController.text.isEmpty) {
      Get.snackbar('Error', 'Kecamatan harus diisi');
      return false;
    }
    if (startHourController.text.isEmpty || endHourController.text.isEmpty) {
      Get.snackbar('Error', 'Jam operasional harus diisi');
      return false;
    }
    if (schedules.isEmpty) {
      Get.snackbar('Error', 'Minimal tambahkan satu jadwal');
      return false;
    }
    return true;
  }

  Future<void> uploadLabTest() async {
    if (!validateInput()) return;

    try {
      isLoading.value = true;

      // Simpan data lab test
      await _firestore.collection('labTests').add({
        'hospital': hospitalController.text,
        'address': addressController.text,
        'currency': 'Rp',
        'description': descriptionController.text,
        'image': imageUrlController.text,
        'location': {
          'city': cityController.text,
          'district': districtController.text,
        },
        'operasionalHours': {
          'start': startHourController.text,
          'end': endHourController.text,
        },
        'price': int.parse(priceController.text),
        'test': testController.text,
        'schedule': schedules.toList(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      _resetForm();
      await Future.delayed(const Duration(seconds: 2));
      Get.back(result: true);

      Get.snackbar(
        'Sukses',
        'Lab Test berhasil ditambahkan',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengunggah Lab Test: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Reset form
  void _resetForm() {
    hospitalController.clear();
    addressController.clear();
    descriptionController.clear();
    imageUrlController.clear();
    testController.clear();
    priceController.clear();
    cityController.clear();
    districtController.clear();
    startHourController.clear();
    endHourController.clear();
    schedules.clear();
  }

  @override
  void onClose() {
    // Dispose semua controller
    hospitalController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    imageUrlController.dispose();
    testController.dispose();
    priceController.dispose();
    cityController.dispose();
    districtController.dispose();
    startHourController.dispose();
    endHourController.dispose();
    scheduleStartController.dispose();
    scheduleEndController.dispose();
    super.onClose();
  }
}
