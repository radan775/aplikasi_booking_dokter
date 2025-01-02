import 'package:get/get.dart';

class BookingBerhasilController extends GetxController {
  Map<String, dynamic> selectedSchedule = {};
  RxString kodePemesanan = ''.obs;
  RxString tipeLayanan = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedSchedule = Get.arguments;
    kodePemesanan.value = selectedSchedule['code'];
    tipeLayanan.value = selectedSchedule['type'] == 'doctor'
        ? 'Janji Dokter'
        : 'Tes Laboratorium';
  }
}
