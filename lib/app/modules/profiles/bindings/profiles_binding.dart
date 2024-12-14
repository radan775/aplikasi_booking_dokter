import 'package:aplikasi_booking_dokter/app/modules/profiles/controllers/profiles_controller.dart';
import 'package:get/get.dart';

class ProfilesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilesController>(
      () => ProfilesController(),
    );
  }
}
