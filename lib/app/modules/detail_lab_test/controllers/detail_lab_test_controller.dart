import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DetailLabTestController extends GetxController {
  Map<String, dynamic> labTestData = {};
  RxMap<String, String> selectedSchedule = <String, String>{}.obs;

  RxString selectedDateText = ''.obs;
  Rx<DateTime?> selectedDateTime = Rx<DateTime?>(null);
  RxString day = ''.obs;

  @override
  void onInit() {
    super.onInit();
    labTestData = Get.arguments;
    print(labTestData);
  }

  void buatJanji(String startTime, String endTime) {
    if (selectedDateText.isNotEmpty) {
      selectedSchedule.clear();
      selectedSchedule.value = {
        "type": "labTest",
        'clinicId': labTestData['id'],
        'day': day.value,
        'startTime': startTime,
        'endTime': endTime,
        'date': selectedDateText.value,
        'fee': labTestData['price'].toString(),
      };
      print(selectedSchedule);

      Get.toNamed(Routes.DETAIL_PEMESAN, arguments: selectedSchedule);
    } else {
      Get.snackbar(
        'Peringatan',
        'Silakan pilih tanggal terlebih dahulu',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 300)),
      helpText: "Pilih Tanggal Janji",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.blueColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      selectedDateTime.value = selectedDate;
      day.value = _getDayName(selectedDate.weekday);
      selectedDateText.value =
          "${selectedDate.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year}";

      print("Tanggal dipilih: ${selectedDateText.value}");
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Senin';
      case DateTime.tuesday:
        return 'Selasa';
      case DateTime.wednesday:
        return 'Rabu';
      case DateTime.thursday:
        return 'Kamis';
      case DateTime.friday:
        return 'Jumat';
      case DateTime.saturday:
        return 'Sabtu';
      case DateTime.sunday:
        return 'Minggu';
      default:
        return '';
    }
  }
}
