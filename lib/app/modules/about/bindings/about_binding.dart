import 'package:aplikasi_booking_dokter/app/modules/about/controllers/about_controller.dart';
import 'package:get/get.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(() => AboutController());
  }
}
