import 'package:get/get.dart';

class DetailHistoryController extends GetxController {
  final Map<String, dynamic> historyData = {
    "doctorImage":
        "https://placehold.jp/100x100.png", // Gambar dokter (gunakan URL placeholder)
    "doctorName": "Dr. John Doe", // Nama dokter
    "doctorSpecialty": "Spesialis Anak", // Spesialisasi dokter
    "clinicImage":
        "https://placehold.jp/150x150.png", // Gambar klinik (gunakan URL placeholder)
    "clinicName": "RSIA Puri Malang", // Nama klinik
    "clinicAddress":
        "Jl. Ahmad Yani No. 1, Blimbing, Kota Malang", // Alamat klinik
    "selectedDay": "Senin", // Hari yang dipilih
    "selectedDate": "1 Januari 2025", // Tanggal yang dipilih
    "selectedTime": "16:00 - 19:00", // Jam yang dipilih
    "patientName": "Jane Doe", // Nama pasien
    "patientBirthDate": "12 Desember 1990", // Tanggal lahir pasien
    "patientEmail": "janedoe@example.com", // Email pasien
    "patientPhone": "081234567890", // Nomor HP pasien
    "patientAddress":
        "Jl. Mawar No. 10, Kelurahan Bunga, Kota Malang", // Alamat pasien
    "patientGender": "Perempuan", // Jenis kelamin pasien
    "paymentMethod": "Dana Pribadi", // Metode pembayaran
    "hasVisited": true, // Status apakah pernah ke rumah sakit ini
  };
}
