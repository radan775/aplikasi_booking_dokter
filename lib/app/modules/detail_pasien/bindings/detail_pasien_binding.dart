import 'package:aplikasi_booking_dokter/app/modules/detail_pasien/controllers/detail_pasien_controller.dart';
import 'package:get/get.dart';

class DetailPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPasienController>(
      () => DetailPasienController(),
    );
  }
}
