import 'package:aplikasi_booking_dokter/app/modules/change_profile/controllers/change_profile_controller.dart';
import 'package:get/get.dart';

class ChangeProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeProfileController>(
      () => ChangeProfileController(),
    );
  }
}
