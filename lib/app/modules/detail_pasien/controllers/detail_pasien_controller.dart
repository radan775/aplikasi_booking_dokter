// Di DetailPasienController
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';

class DetailPasienController extends GetxController {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final RxString selectedGender = ''.obs;

  Map<String, dynamic> selectedSchedule = {};

  @override
  void onInit() {
    super.onInit();
    selectedSchedule = Get.arguments ?? {};
  }

  bool validatePasienData() {
    if (namaController.text.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Nama pasien harus diisi',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (tanggalController.text.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Tanggal lahir harus diisi',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (selectedGender.value.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Jenis kelamin harus dipilih',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (nikController.text.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'NIK/No KTP harus diisi',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (nikController.text.length != 16) {
      Get.snackbar(
        'Peringatan',
        'NIK/No KTP harus terdiri dari 16 digit',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (alamatController.text.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Alamat harus diisi',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  void simpanDataPasien() {
    if (validatePasienData()) {
      Map<String, dynamic> dataPasien = {
        'nama': namaController.text,
        'tanggalLahir': tanggalController.text,
        'jenisKelamin': selectedGender.value,
        'nik': nikController.text,
        'alamat': alamatController.text,
      };

      // Buat salinan baru dari selectedSchedule
      var updatedSchedule = Map<String, dynamic>.from(selectedSchedule);
      updatedSchedule['pasien'] = dataPasien;

      Get.toNamed(Routes.DETAIL_DATA_PASIEN, arguments: updatedSchedule);
    }
  }
}
