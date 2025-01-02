import 'package:aplikasi_booking_dokter/app/modules/lab_test/controllers/lab_test_controller.dart';
import 'package:get/get.dart';

class LabTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LabTestController>(
      () => LabTestController(),
    );
  }
}
