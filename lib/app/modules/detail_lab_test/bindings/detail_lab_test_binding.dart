import 'package:aplikasi_booking_dokter/app/modules/detail_lab_test/controllers/detail_lab_test_controller.dart';
import 'package:get/get.dart';

class DetailLabTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailLabTestController>(
      () => DetailLabTestController(),
    );
  }
}
