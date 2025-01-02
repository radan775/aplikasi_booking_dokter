import 'package:aplikasi_booking_dokter/app/modules/detail_doctor/controllers/detail_doctor_controller.dart';
import 'package:get/get.dart';

class DetailDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailDoctorController>(
      () => DetailDoctorController(),
    );
  }
}
