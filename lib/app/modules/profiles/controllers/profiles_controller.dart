import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/strings.dart';

class ProfilesController extends GetxController {
  final GetStorage _storage = GetStorage();

  var settingsList = [
    AppStrings.changePassword,
    AppStrings.termsCondition,
    AppStrings.help,
    AppStrings.about,
    AppStrings.signout,
  ];

  void signOut() {
    _storage.remove('userId');
    _storage.remove('role');
    _storage.write('isLogin', false);

    Get.offAllNamed(Routes.LOGIN);
  }
}
