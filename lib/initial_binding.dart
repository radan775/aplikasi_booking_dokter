import 'package:aplikasi_booking_dokter/event_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EventController>(EventController(), permanent: true);
  }
}
