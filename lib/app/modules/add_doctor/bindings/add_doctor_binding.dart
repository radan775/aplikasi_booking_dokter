import 'package:aplikasi_booking_dokter/app/modules/add_doctor/controllers/add_doctor_controller.dart';
import 'package:get/get.dart';

class AddDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDoctorController>(
      () => AddDoctorController(),
    );
  }
}
