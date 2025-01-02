import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _storage = GetStorage();

  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> historyList = <Map<String, dynamic>>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      isLoading.value = true;
      String? userId = _storage.read('userId');

      if (userId == null) {
        print('User ID tidak ditemukan');
        isLoading.value = false;
        return;
      }

      final historySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('history')
          .get();

      historyList.value = historySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['code'] = doc.id;
        return data;
      }).toList();

      historyList.sort((a, b) {
        DateTime dateA = _parseDate(a['selectedDate'] ?? '');
        DateTime dateB = _parseDate(b['selectedDate'] ?? '');
        return dateB.compareTo(dateA);
      });
    } catch (e) {
      print('Error fetching history: $e');
      Get.snackbar(
        'Error',
        'Gagal mengambil riwayat',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  DateTime _parseDate(String dateString) {
    try {
      final months = {
        'Januari': 1,
        'Februari': 2,
        'Maret': 3,
        'April': 4,
        'Mei': 5,
        'Juni': 6,
        'Juli': 7,
        'Agustus': 8,
        'September': 9,
        'Oktober': 10,
        'November': 11,
        'Desember': 12,
      };
      List<String> parts = dateString.split(' ');

      if (parts.length == 4) {
        // Hapus koma dari hari
        String dayStr = parts[1].replaceAll(',', '');

        int day = int.parse(dayStr);
        int month = months[parts[2]] ?? 1;
        int year = int.parse(parts[3]);

        return DateTime(year, month, day);
      }
      // Cek format: "15 Januari 2024"
      else if (parts.length == 3) {
        int day = int.parse(parts[0]);
        int month = months[parts[1]] ?? 1;
        int year = int.parse(parts[2]);

        return DateTime(year, month, day);
      }
      // Format lain yang mungkin: "2024-01-15"
      else if (parts.length == 1 && dateString.contains('-')) {
        List<String> dateParts = dateString.split('-');
        if (dateParts.length == 3) {
          int year = int.parse(dateParts[0]);
          int month = int.parse(dateParts[1]);
          int day = int.parse(dateParts[2]);
          return DateTime(year, month, day);
        }
      }

      print('Format tanggal tidak dikenali: $dateString');
      return DateTime.now();
    } catch (e) {
      print('Error parsing date: $e');
      return DateTime.now();
    }
  }
}
