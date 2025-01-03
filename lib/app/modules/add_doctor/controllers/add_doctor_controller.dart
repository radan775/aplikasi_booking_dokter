import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDoctorController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text Controllers
  final nameController = TextEditingController();
  final currency = 'Rp';
  final profileController = TextEditingController();
  final specialtyController = TextEditingController();
  final feeController = TextEditingController();
  final imageController = TextEditingController();
  final educationController = TextEditingController();
  final experienceController = TextEditingController();
  final treatmentsController = TextEditingController();

  // Clinic Information
  final clinicNameController = TextEditingController();
  final clinicAddressController = TextEditingController();
  final clinicCityController = TextEditingController();
  final clinicDistrictController = TextEditingController();
  final clinicImageController = TextEditingController();
  final scheduleDayController = TextEditingController(); // Tambahkan ini
  final scheduleStartController = TextEditingController(); // Tambahkan ini
  final scheduleEndController = TextEditingController(); // Tambahkan ini
  RxList<String> educationList = <String>[].obs;
  RxList<String> experienceList = <String>[].obs;
  RxList<String> treatmentsList = <String>[].obs;
  RxList<Map<String, dynamic>> clinicList = <Map<String, dynamic>>[].obs;

  void addEducation(String education) {
    if (education.isNotEmpty) {
      educationList.add(education);
      educationController.clear(); // Kosongkan input setelah menambah
    }
  }

  // Method untuk menambah pengalaman
  void addExperience(String experience) {
    if (experience.isNotEmpty) {
      experienceList.add(experience);
      experienceController.clear(); // Kosongkan input setelah menambah
    }
  }

  void addTreatment(String treatment) {
    if (treatment.isNotEmpty) {
      treatmentsList.add(treatment);
      treatmentsController.clear(); // Kosongkan input setelah menambah
    }
  }

  // Method untuk menghapus pendidikan
  void removeEducation(int index) {
    educationList.removeAt(index);
  }

  // Method untuk menghapus pengalaman
  void removeExperience(int index) {
    experienceList.removeAt(index);
  }

  void removeTreatment(int index) {
    treatmentsList.removeAt(index);
  }

  // Schedule Information
  RxList<Map<String, dynamic>> schedules = <Map<String, dynamic>>[].obs;

  // Loading State
  RxBool isLoading = false.obs;

  // Method untuk menambahkan jadwal
  void addSchedule(String day, String startTime, String endTime) {
    if (day.isNotEmpty && startTime.isNotEmpty && endTime.isNotEmpty) {
      schedules.add({
        'day': day,
        'startTime': startTime,
        'endTime': endTime,
      });
      scheduleDayController.clear();
      scheduleStartController.clear();
      scheduleEndController.clear();
    } else {
      Get.snackbar('Error', 'Semua field jadwal harus diisi');
    }
  }

  // Hapus jadwal
  void removeSchedule(int index) {
    schedules.removeAt(index);
  }

  void saveClinicData() {
    if (validateClinicInput()) {
      clinicList.add({
        'name': clinicNameController.text,
        'address': clinicAddressController.text,
        'city': clinicCityController.text,
        'district': clinicDistrictController.text,
        'image': clinicImageController.text,
        'schedules': schedules.toList(), // Simpan jadwal
      });
      clearClinicFields();
      Get.back(); // Kembali ke halaman sebelumnya
    }
  }

  // Validasi input
  bool validateDoctorInput() {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Nama dokter harus diisi');
      return false;
    }
    if (profileController.text.isEmpty) {
      Get.snackbar('Error', 'Deskripsi dokter harus diisi');
      return false;
    }
    if (specialtyController.text.isEmpty) {
      Get.snackbar('Error', 'Spesialisasi dokter harus diisi');
      return false;
    }
    if (feeController.text.isEmpty) {
      Get.snackbar('Error', 'Biaya konsultasi harus diisi');
      return false;
    }

    if (experienceList.isEmpty) {
      Get.snackbar('Error', 'Minimal satu treatment harus diisi');
      return false;
    }

    if (educationList.isEmpty) {
      Get.snackbar('Error', 'Minimal satu pendidikan harus diisi');
      return false;
    }

    if (treatmentsList.isEmpty) {
      Get.snackbar('Error', 'Minimal satu treatment harus diisi');
      return false;
    }
    return true;
  }

  // Validasi input klinik
  bool validateClinicInput() {
    if (clinicNameController.text.isEmpty) {
      Get.snackbar('Error', 'Nama klinik harus diisi');
      return false;
    }
    if (clinicAddressController.text.isEmpty) {
      Get.snackbar('Error', 'Alamat klinik harus diisi');
      return false;
    }
    if (clinicCityController.text.isEmpty) {
      Get.snackbar('Error', 'Kota klinik harus diisi');
      return false;
    }
    if (clinicDistrictController.text.isEmpty) {
      Get.snackbar('Error', 'Kecamatan klinik harus diisi');
      return false;
    }

    if (clinicImageController.text.isEmpty) {
      Get.snackbar('Error', 'Url gambar klinik harus diisi');
      return false;
    }

    if (schedules.isEmpty) {
      Get.snackbar('Error', 'Minimal ada 1 jadwal ditambahkan');
    }
    return true;
  }

  Future<void> uploadDoctorData() async {
    if (clinicList.isEmpty) {
      Get.snackbar(
        'Error',
        'Minimal 1 klinik harus ditambahkan sebelum mengunggah data dokter.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!validateDoctorInput()) return;

    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 2));

      // Simpan data dokter
      DocumentReference doctorRef = await _firestore.collection('doctors').add({
        'name': nameController.text,
        'currency': currency,
        'profile': profileController.text,
        'specialty': specialtyController.text,
        'fee': int.parse(feeController.text),
        'image': imageController.text,
        'education': educationList.toList(),
        'experiences': experienceList.toList(),
        'treatments': treatmentsList.toList(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Simpan sub-koleksi klinik
      for (var clinic in clinicList) {
        await doctorRef.collection('clinics').add({
          'clinic': {
            'name': clinic['name'],
            'address': clinic['address'],
            'city': clinic['city'],
            'district': clinic['district'],
            'image': clinic['image'],
          },
          'schedule': clinic['schedules'],
        });
      }

      // Reset form
      _resetForm();

      Get.back(result: true);
      Get.snackbar(
        'Sukses',
        'Data dokter berhasil diunggah!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengunggah data dokter: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearClinicFields() {
    clinicNameController.clear();
    clinicAddressController.clear();
    clinicCityController.clear();
    clinicDistrictController.clear();
    clinicImageController.clear();
    schedules.clear();
  }

  // Reset form
  void _resetForm() {
    nameController.clear();
    profileController.clear();
    specialtyController.clear();
    feeController.clear();
    imageController.clear();
    educationController.clear();
    experienceController.clear();
    treatmentsController.clear();
    clinicNameController.clear();
    clinicAddressController.clear();
    clinicCityController.clear();
    clinicDistrictController.clear();
    clinicImageController.clear();
    schedules.clear();
    educationList.clear();
    experienceList.clear();
    treatmentsList.clear();
  }

  @override
  void onClose() {
    // Dispose semua controller
    nameController.dispose();
    profileController.dispose();
    specialtyController.dispose();
    feeController.dispose();
    imageController.dispose();
    educationController.dispose();
    experienceController.dispose();
    treatmentsController.dispose();
    clinicNameController.dispose();
    clinicAddressController.dispose();
    clinicCityController.dispose();
    clinicDistrictController.dispose();
    clinicImageController.dispose();
    super.onClose();
  }
}
