import 'package:get/get.dart';

class DetailDataPasienController extends GetxController {
  final RxString selectedVisitStatus = ''.obs;
  final RxString selectedPaymentMethod = ''.obs;
  final doctorData = {
    "name": "Dr. John Doe",
    "specialty": "Spesialis Anak",
    "image": "https://placehold.jp/150x150.png"
  };

  final clinicData = {
    "clinicName": "RSIA Puri Malang",
    "scheduleDay": "Senin",
    "scheduleDate": "8 Januari 2025",
    "scheduleTime": "16:00 - 19:00",
    "clinicImage": "https://placehold.jp/100x100.png",
    "fee": 250000
  };

  final userData = {
    "phone": "081234567890",
    "email": "user@example.com",
    "fullName": "John Smith"
  };
}
