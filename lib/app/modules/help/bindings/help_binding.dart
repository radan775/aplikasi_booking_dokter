import 'package:aplikasi_booking_dokter/app/modules/help/controllers/help_controller.dart';
import 'package:get/get.dart';

class HelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpController>(() => HelpController());
  }
}
