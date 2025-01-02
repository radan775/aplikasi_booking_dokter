import 'package:get/get.dart';

class HistoryController extends GetxController {
  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. John Doe",
      "specialty": "Mulut",
      "clinic": "Klinik Dokter Sehat",
      "fee": "Rp150.000",
      "image":
          "https://i.pinimg.com/736x/06/b1/85/06b185e5b2322f1ab0557db59b554cd5.jpg",
      "date": "2024-04-15",
      "code": "DOC-42026",
    },
    {
      "name": "Dr. Jane Smith",
      "specialty": "THT",
      "clinic": "Klinik Ceria",
      "fee": "Rp200.000",
      "image":
          "https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/fffd9126-dda4-430c-a18d-fb33c6493c57/de210368-9622-4654-b8c7-a7f24673cb00.png",
      "date": "2024-06-07",
      "code": "DOC-34737",
    },
  ];

  final List<Map<String, dynamic>> labTests = [
    {
      "hospital": "RS Mitra Keluarga",
      "test": "Swab PCR",
      "location": {"district": "Cakung", "city": "Jakarta Timur"},
      "price": "Rp900.000",
      "image":
          "https://img.freepik.com/free-vector/hospital-building_23-2148161322.jpg",
      "date": "2024-01-09",
      "code": "LAB-17619",
    },
    {
      "hospital": "RS Hermina",
      "test": "Tes Darah Lengkap",
      "location": {"district": "Depok", "city": "Jawa Barat"},
      "price": "Rp450.000",
      "image":
          "https://img.freepik.com/premium-vector/flat-hospital-building-illustration_1200-572.jpg",
      "date": "2024-09-23",
      "code": "LAB-15083",
    },
    {
      "hospital": "RS Awal Bros",
      "test": "Cek Kolesterol",
      "location": {"district": "Bekasi Selatan", "city": "Bekasi"},
      "price": "Rp300.000",
      "image":
          "https://img.freepik.com/premium-vector/modern-hospital-clinic-building_133260-284.jpg",
      "date": "2024-08-26",
      "code": "LAB-86153",
    },
  ];

  late final List<Map<String, dynamic>> historyList;

  @override
  void onInit() {
    super.onInit();

    // Gabungkan doctors dan labTests ke dalam historyList
    historyList = [
      ...doctors.map((doctor) => {
            "type": "doctor",
            ...doctor,
          }),
      ...labTests.map((labTest) => {
            "type": "labTest",
            ...labTest,
          }),
    ];
  }

  String _generateCode(String prefix) {
    final random = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    return "$prefix-${random.toString().padLeft(5, '0')}";
  }
}
