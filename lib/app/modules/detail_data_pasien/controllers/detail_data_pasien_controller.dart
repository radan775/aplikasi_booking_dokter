import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

class DetailDataPasienController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _storage = GetStorage();

  final RxString selectedVisitStatus = ''.obs;
  final RxString selectedPaymentMethod = ''.obs;
  Map<String, dynamic> selectedSchedule = {};
  Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});
  Rx<Map<String, dynamic>> selectedDoctorData = Rx<Map<String, dynamic>>({});
  Rx<Map<String, dynamic>> selectedClinicData = Rx<Map<String, dynamic>>({});
  RxString kodePemesanan = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    selectedSchedule = Get.arguments ?? {};
    print(selectedSchedule);

    String? userId = _storage.read('userId');
    if (userId != null) {
      await fetchUserData(userId);
    }

    if (selectedSchedule['type'] == 'doctor') {
      await fetchDoctorData(selectedSchedule['doctorId']);
      await fetchClinicData(
          selectedSchedule['doctorId'], selectedSchedule['clinicId']);
    } else {
      await fetchLabTestData(selectedSchedule['clinicId']);
    }
    generateKodePemesanan();
    print(selectedSchedule);
  }

  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        Map<String, dynamic> userDataMap =
            userDoc.data() as Map<String, dynamic>;
        userData.value = {
          "nomorhp": userDataMap['nomorhp'] ?? '',
          "email": userDataMap['email'] ?? '',
          "namalengkap": userDataMap['namalengkap'] ?? '',
        };
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchLabTestData(String labTestId) async {
    try {
      DocumentSnapshot labTestDoc =
          await _firestore.collection('labTests').doc(labTestId).get();
      if (labTestDoc.exists) {
        selectedClinicData.value = {
          "name": labTestDoc['hospital'] ?? 'Nama Lab Test Tidak Tersedia',
          "test": labTestDoc['test'] ?? 'Kategori Tidak Diketahui',
          "clinicImage":
              labTestDoc['image'] ?? 'https://placehold.jp/150x150.png',
          "scheduleDay": selectedSchedule['day'] ?? 'Hari Tidak Diketahui',
          "scheduleDate": selectedSchedule['date'] ?? 'Tanggal Tidak Diketahui',
          "scheduleTime":
              "${selectedSchedule['startTime']} - ${selectedSchedule['endTime']}",
          'fee': labTestDoc['price'] ?? 0,
          "clinicAddress": labTestDoc['address'] ?? 'Alamat Tidak Tersedia',
        };
      }
    } catch (e) {
      print('Error fetching lab test data: $e');
    }
  }

  Future<void> fetchDoctorData(String doctorId) async {
    try {
      DocumentSnapshot doctorDoc =
          await _firestore.collection('doctors').doc(doctorId).get();
      if (doctorDoc.exists) {
        selectedDoctorData.value = {
          "name": doctorDoc['name'] ?? 'Nama Dokter Tidak Tersedia',
          "specialty": doctorDoc['specialty'] ?? 'Spesialis Tidak Diketahui',
          "image": doctorDoc['image'] ?? 'https://placehold.jp/150x150.png',
          'fee': doctorDoc['fee'] ?? 0
        };
      }
    } catch (e) {
      print('Error fetching doctor data: $e');
    }
  }

  Future<void> fetchClinicData(String doctorId, String clinicId) async {
    try {
      DocumentSnapshot clinicDoc = await _firestore
          .collection('doctors')
          .doc(doctorId)
          .collection('clinics')
          .doc(clinicId)
          .get();

      if (clinicDoc.exists) {
        selectedClinicData.value = {
          "clinicName":
              clinicDoc['clinic']['name'] ?? 'Nama Klinik Tidak Tersedia',
          "scheduleDay": selectedSchedule['day'] ?? 'Hari Tidak Diketahui',
          "scheduleDate": selectedSchedule['date'] ?? 'Tanggal Tidak Diketahui',
          "scheduleTime":
              "${selectedSchedule['startTime']} - ${selectedSchedule['endTime']}",
          "clinicImage": clinicDoc['clinic']['image'] ??
              'https://placehold.jp/100x100.png',
          "fee": selectedSchedule['fee'] ?? 0,
          "clinicAddress":
              clinicDoc['clinic']['address'] ?? 'Alamat Tidak Tersedia',
        };
      }
    } catch (e) {
      print('Error fetching clinic data: $e');
    }
  }

  Future<void> updateUserData() async {
    try {
      String? userId = _storage.read('userId');

      if (userId == null) {
        Get.snackbar(
          'Error ID Tidak Ditemukan',
          'Silahkan logout dan login kembali',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      Map<String, dynamic> historyData = {
        // Data umum untuk semua tipe
        "selectedDay": selectedSchedule['day'],
        "selectedDate": selectedSchedule['date'],
        "selectedTime":
            "${selectedSchedule['startTime']} - ${selectedSchedule['endTime']}",
        "patientName": selectedSchedule['pasien']['nama'],
        "patientBirthdate": selectedSchedule['pasien']['tanggalLahir'],
        "patientEmail": userData.value['email'],
        "patientPhone": userData.value['nomorhp'],
        "patientAddress": selectedSchedule['pasien']['alamat'],
        "patientGender": selectedSchedule['pasien']['jenisKelamin'],
        "paymentMethod": selectedPaymentMethod.value,
        "hasVisited": selectedVisitStatus.value,
        "code": kodePemesanan.value,
        "type": selectedSchedule['type'],
      };

      if (selectedSchedule['type'] == 'doctor') {
        historyData.addAll({
          "doctorImage": selectedDoctorData.value['image'],
          "doctorName": selectedDoctorData.value['name'],
          "doctorSpecialty": selectedDoctorData.value['specialty'],
          "clinicName": selectedClinicData.value['clinicName'],
          "clinicImage": selectedClinicData.value['clinicImage'],
          "clinicAddress": selectedClinicData.value['clinicAddress'] ?? '',
        });
      } else {
        historyData.addAll({
          "clinicName": selectedClinicData.value['name'],
          "clinicImage": selectedClinicData.value['clinicImage'],
          "clinicAddress": selectedClinicData.value['clinicAddress'] ?? '',
        });
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('history')
          .doc(kodePemesanan.value)
          .set(historyData);

      print('History berhasil disimpan');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menyimpan riwayat: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error menyimpan history: $e');
    }
  }

  Future<void> selesaikanPemesanan() async {
    try {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            color: AppColors.blueColor,
          ),
        ),
        barrierDismissible: false,
      );

      if (selectedVisitStatus.value.isEmpty) {
        Get.back();
        Get.snackbar(
          'Peringatan',
          'Silakan pilih status kunjungan',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      if (selectedPaymentMethod.value.isEmpty) {
        Get.back(); // Tutup loading
        Get.snackbar(
          'Peringatan',
          'Silakan pilih metode pembayaran',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      await Future.delayed(const Duration(seconds: 2));

      selectedSchedule['visitStatus'] = selectedVisitStatus.value;
      selectedSchedule['paymentMethod'] = selectedPaymentMethod.value;
      selectedSchedule['code'] = kodePemesanan.value;
      await updateUserData();
      Get.back();
      Get.offAllNamed(Routes.BOOKING_BERHASIL, arguments: selectedSchedule);
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'Gagal menyelesaikan pemesanan: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void generateKodePemesanan() {
    String tipe = selectedSchedule['type'] == 'doctor' ? 'DOC' : 'LAB';
    String randomCode = const Uuid().v4().substring(0, 13).toUpperCase();
    kodePemesanan.value = '$tipe-$randomCode';
  }
}
