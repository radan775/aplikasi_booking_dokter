import 'package:aplikasi_booking_dokter/app/modules/term_condition/controllers/term_condition_controller.dart';
import 'package:get/get.dart';

class TermConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermConditionController>(
      () => TermConditionController(),
    );
  }
}
