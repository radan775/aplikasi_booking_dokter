import 'package:get/get.dart';

class NotificationController extends GetxController {
  // Data dummy untuk notifikasi
  final notifications = [
    {
      "title": "Jadwal Konsultasi",
      "message": "Jadwal konsultasi dengan Dr. John Doe telah dikonfirmasi.",
      "date": "2025-01-01",
    },
    {
      "title": "Pembayaran Berhasil",
      "message": "Pembayaran untuk layanan konsultasi berhasil.",
      "date": "2025-01-02",
    },
    {
      "title": "Promo Tahun Baru",
      "message": "Nikmati diskon 20% untuk konsultasi selama Januari!",
      "date": "2025-01-03",
    },
  ].obs;
}
