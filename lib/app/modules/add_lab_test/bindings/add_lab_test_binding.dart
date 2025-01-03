import 'package:aplikasi_booking_dokter/app/modules/add_lab_test/controllers/add_lab_test_controller.dart';
import 'package:get/get.dart';

class AddLabTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLabTestController>(
      () => AddLabTestController(),
    );
  }
}
