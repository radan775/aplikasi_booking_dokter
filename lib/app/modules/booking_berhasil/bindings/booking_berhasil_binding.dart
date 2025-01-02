import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/modules/booking_berhasil/controllers/booking_berhasil_controller.dart';

class BookingBerhasilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingBerhasilController>(
      () => BookingBerhasilController(),
    );
  }
}
