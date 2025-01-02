import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailDoctorController extends GetxController {
  Map<String, dynamic> doctorData = {};
  RxMap<String, Map<String, String>> selectedSchedule =
      <String, Map<String, String>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    doctorData = Get.arguments ?? {};
  }

  void selectSchedule(String doctorId, String clinicId, String day,
      String startTime, String endTime) {
    selectedSchedule.clear();
    selectedSchedule[clinicId] = {
      'doctorId': doctorId,
      'clinicId': clinicId,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  /// Mendapatkan tanggal berikutnya berdasarkan nama hari
  String getNextDateForDay(String dayName) {
    final now = DateTime.now();
    final daysOfWeek = {
      'senin': 1,
      'selasa': 2,
      'rabu': 3,
      'kamis': 4,
      'jumat': 5,
      'sabtu': 6,
      'minggu': 7,
    };

    final targetDay = daysOfWeek[dayName.toLowerCase()];
    if (targetDay == null) return 'Invalid Day';

    int daysDifference = (targetDay - now.weekday) % 7;
    if (daysDifference <= 0) daysDifference += 7; // Jika hari sudah lewat

    final nextDate = now.add(Duration(days: daysDifference));
    return DateFormat('dd MMMM yyyy').format(nextDate);
  }
}
