import 'package:aplikasi_booking_dokter/app/modules/berita/controllers/berita_controller.dart';
import 'package:aplikasi_booking_dokter/app/modules/bottom_navbar/controllers/navbar_bottom_controller.dart';
import 'package:aplikasi_booking_dokter/app/modules/history/controllers/history_controller.dart';
import 'package:aplikasi_booking_dokter/app/modules/home/controllers/home_controller.dart';
import 'package:aplikasi_booking_dokter/app/modules/lab_test/controllers/lab_test_controller.dart';
import 'package:aplikasi_booking_dokter/app/modules/profiles/controllers/profiles_controller.dart';
import 'package:get/get.dart';

class NavbarBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarBottomController>(
      () => NavbarBottomController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LabTestController>(
      () => LabTestController(),
    );
    Get.lazyPut<BeritaController>(
      () => BeritaController(),
    );
    Get.lazyPut<HistoryController>(
      () => HistoryController(),
    );
    Get.lazyPut<ProfilesController>(
      () => ProfilesController(),
    );
  }
}
