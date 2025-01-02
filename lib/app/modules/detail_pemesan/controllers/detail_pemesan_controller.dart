import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailPemesanController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _storage = GetStorage();

  Map<String, dynamic> selectedSchedule = {};
  Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});
  Rx<Map<String, dynamic>> selectedDoctorData = Rx<Map<String, dynamic>>({});
  Rx<Map<String, dynamic>> selectedClinicData = Rx<Map<String, dynamic>>({});

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
    }
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
          "fee": selectedSchedule['fee'] ?? 0
        };
      }
    } catch (e) {
      print('Error fetching clinic data: $e');
    }
  }

  bool validateForm(String phone, String email, String fullName) {
    // Validasi nomor ponsel
    if (phone.isEmpty || phone.length < 10) {
      Get.snackbar(
        'Peringatan',
        'Nomor ponsel tidak valid',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar(
        'Peringatan',
        'Email tidak valid',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (fullName.isEmpty || fullName.length < 2) {
      Get.snackbar(
        'Peringatan',
        'Nama lengkap tidak valid',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<void> updateUserData(
      String phone, String email, String fullName) async {
    try {
      String? userId = _storage.read('userId');
      if (userId != null) {
        await _firestore.collection('users').doc(userId).update({
          'nomorhp': phone,
          'email': email,
          'namalengkap': fullName,
        });

        userData.value = {
          'nomorhp': phone,
          'email': email,
          'namalengkap': fullName,
        };

        Get.toNamed(Routes.DETAIL_PASIEN, arguments: selectedSchedule);
      }
    } catch (e) {
      print('Error updating user data: $e');
      Get.snackbar(
        'Error',
        'Gagal memperbarui data',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
