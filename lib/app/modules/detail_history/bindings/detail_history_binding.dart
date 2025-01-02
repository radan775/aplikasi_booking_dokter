import 'package:aplikasi_booking_dokter/app/modules/detail_history/controllers/detail_history_controller.dart';
import 'package:get/get.dart';

class DetailHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailHistoryController>(
      () => DetailHistoryController(),
    );
  }
}
