import 'package:get/get.dart';

class LabTestController extends GetxController {
  // List data dummy untuk lab test
  final List<Map<String, dynamic>> labTests = [
    {
      "hospital": "RS Mitra Keluarga",
      "test": "Swab PCR",
      "location": {"district": "Cakung", "city": "Jakarta Timur"},
      "price": "Rp900.000",
      "image":
          "https://img.freepik.com/free-vector/hospital-building_23-2148161322.jpg",
    },
    {
      "hospital": "RS Hermina",
      "test": "Tes Darah Lengkap",
      "location": {"district": "Depok", "city": "Jawa Barat"},
      "price": "Rp450.000",
      "image":
          "https://img.freepik.com/premium-vector/flat-hospital-building-illustration_1200-572.jpg",
    },
    {
      "hospital": "RS Awal Bros",
      "test": "Cek Kolesterol",
      "location": {"district": "Bekasi Selatan", "city": "Bekasi"},
      "price": "Rp300.000",
      "image":
          "https://img.freepik.com/premium-vector/modern-hospital-clinic-building_133260-284.jpg",
    },
    {
      "hospital": "RS Siloam",
      "test": "Cek Gula Darah",
      "location": {"district": "Serpong", "city": "Tangerang Selatan"},
      "price": "Rp250.000",
      "image":
          "https://img.freepik.com/free-vector/hospital-building-flat-background_23-2147752379.jpg",
    },
    {
      "hospital": "RS Mayapada",
      "test": "Cek Tekanan Darah",
      "location": {"district": "Setiabudi", "city": "Jakarta Selatan"},
      "price": "Rp200.000",
      "image":
          "https://img.freepik.com/free-vector/medical-center-building_23-2148550024.jpg",
    },
    {
      "hospital": "RS Permata Depok",
      "test": "Tes Antigen",
      "location": {"district": "Pancoran Mas", "city": "Depok"},
      "price": "Rp150.000",
      "image":
          "https://img.freepik.com/free-vector/hospital-front-building-doctors_107791-1894.jpg",
    },
    {
      "hospital": "RS Pondok Indah",
      "test": "Cek Fungsi Ginjal",
      "location": {"district": "Kebayoran Lama", "city": "Jakarta Selatan"},
      "price": "Rp750.000",
      "image":
          "https://img.freepik.com/free-vector/hospital-building-front-view_1308-77912.jpg",
    },
  ];

  final List<String> labTestTypes = [
    "Swab PCR",
    "Tes Darah Lengkap",
    "Cek Kolesterol",
    "Tes Antigen",
    "Cek Gula Darah",
    "Cek Tekanan Darah",
    "Cek Fungsi Ginjal"
  ];
}
