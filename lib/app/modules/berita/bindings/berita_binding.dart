import 'package:aplikasi_booking_dokter/app/modules/berita/controllers/berita_controller.dart';
import 'package:get/get.dart';

class BeritaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeritaController>(() => BeritaController());
  }
}
