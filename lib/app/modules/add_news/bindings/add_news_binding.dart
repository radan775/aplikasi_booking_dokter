import 'package:aplikasi_booking_dokter/app/modules/add_news/controllers/add_news_controller.dart';
import 'package:get/get.dart';

class AddNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewsController>(
      () => AddNewsController(),
    );
  }
}
