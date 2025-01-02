import 'package:aplikasi_booking_dokter/app/modules/detail_data_pasien/controllers/detail_data_pasien_controller.dart';
import 'package:get/get.dart';

class DetailDataPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailDataPasienController>(
      () => DetailDataPasienController(),
    );
  }
}
