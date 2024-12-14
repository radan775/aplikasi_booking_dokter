import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. John Doe",
      "specialty": "Mulut",
      "clinic": "Klinik Dokter Sehat",
      "fee": "Rp150.000",
      "image":
          "https://i.pinimg.com/736x/06/b1/85/06b185e5b2322f1ab0557db59b554cd5.jpg",
    },
    {
      "name": "Dr. Jane Smith",
      "specialty": "THT",
      "clinic": "Klinik Ceria",
      "fee": "Rp200.000",
      "image":
          "https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/fffd9126-dda4-430c-a18d-fb33c6493c57/de210368-9622-4654-b8c7-a7f24673cb00.png",
    },
    {
      "name": "Dr. Emily White",
      "specialty": "Anak",
      "clinic": "Klinik Keluarga",
      "fee": "Rp250.000",
      "image":
          "https://static.vecteezy.com/system/resources/previews/024/585/400/non_2x/3d-happy-cartoon-doctor-cartoon-doctor-on-transparent-background-generative-ai-png.png",
    },
    {
      "name": "Dr. Michael Brown",
      "specialty": "Gigi",
      "clinic": "Klinik Gigi Bersih",
      "fee": "Rp180.000",
      "image":
          "https://st4.depositphotos.com/22230270/24155/v/1600/depositphotos_241559444-stock-illustration-illustration-cartoon-character-female-doctor.jpg",
    },
    {
      "name": "Dr. Sarah Lee",
      "specialty": "Kandungan",
      "clinic": "Klinik Wanita Sehat",
      "fee": "Rp300.000",
      "image":
          "https://img.freepik.com/premium-vector/female-doctor-cartoon-character-with-stethoscope-vector-illustration-female-doctor-uniform_1142-72453.jpg",
    },
    {
      "name": "Dr. Alex Green",
      "specialty": "Umum",
      "clinic": "Klinik Umum",
      "fee": "Rp120.000",
      "image":
          "https://img.freepik.com/premium-vector/simple-female-doctor-cartoon-vector-art-illustration_1048368-431.jpg",
    },
    {
      "name": "Dr. Olivia Black",
      "specialty": "Penyakit Dalam",
      "clinic": "Klinik Medis",
      "fee": "Rp220.000",
      "image":
          "https://img.freepik.com/free-vector/hand-drawn-doctor-cartoon-illustration_23-2150680327.jpg",
    },
  ];

  final List<String> doctorTypes = [
    "Umum",
    "Anak",
    "THT",
    "Gigi",
    "Jantung",
    "Kandungan",
    "Saraf",
    "Kulit",
    "Mata",
    "Bedah"
  ];
}
