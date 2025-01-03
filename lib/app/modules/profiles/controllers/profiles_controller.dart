import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilesController extends GetxController {
  final GetStorage _storage = GetStorage();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var settingsList = [
    AppStrings.changePassword,
    AppStrings.termsCondition,
    AppStrings.help,
    AppStrings.about,
    AppStrings.signout,
  ];

  var userName = "".obs;
  var userEmail = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    final userId = _storage.read('userId');
    if (userId != null) {
      try {
        final userDoc = await _firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          userName.value =
              userDoc.data()?['namalengkap'] ?? "Nama Tidak Ditemukan";
          userEmail.value = userDoc.data()?['email'] ?? "Email Tidak Ditemukan";
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Gagal mengambil data pengguna: ${e.toString()}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  void signOut() {
    _storage.remove('userId');
    _storage.remove('role');
    _storage.write('isLogin', false);

    Get.offAllNamed(Routes.LOGIN);
  }
}
