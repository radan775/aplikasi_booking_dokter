import 'package:aplikasi_booking_dokter/app/modules/detail_pemesan/controllers/detail_pemesan_controller.dart';
import 'package:get/get.dart';

class DetailPemesanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPemesanController>(() => DetailPemesanController());
  }
}
