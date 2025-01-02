import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LabTestController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> labTests = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;

  final List<String> labTestTypes = [
    "Swab PCR",
    "Tes Darah Lengkap",
    "Cek Kolesterol",
    "Tes Antigen",
    "Cek Gula Darah",
    "Cek Tekanan Darah",
    "Cek Fungsi Ginjal"
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchLabTests();
    //await updateLabTestsData();
  }

  String formatFee(String currency, int fee) {
    final formatter = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: 0,
    );
    return "$currency${formatter.format(fee)}";
  }

  Future<void> fetchLabTests() async {
    try {
      isLoading.value = true; // Set loading status
      final querySnapshot = await _firestore.collection('labTests').get();
      final List<Map<String, dynamic>> loadedLabTests =
          querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          "hospital": data['hospital'] ?? '',
          "test": data['test'] ?? '',
          "location": data['location'] ??
              {
                "district": '',
                "city": '',
              },
          "currency": data['currency'] ?? 'Rp',
          "price": data['price'] ?? 0,
          "image": data['image'] ?? '',
          "address": data['address'] ?? '',
          'description': data['description'] ?? '',
          'operasionalHours': data['operasionalHours'] ??
              {
                'start': '08:00',
                'end': '20:00',
              },
          'schedule': data['schedule'] ??
              [
                {
                  'start': '08:00',
                  'end': '10:00',
                  'type': 'Pagi',
                },
                {
                  'start': '13:00',
                  'end': '15:00',
                  'type': 'Siang',
                },
                {
                  'start': '15:00',
                  'end': '17:00',
                  'type': 'Sore',
                },
              ],
        };
      }).toList();

      labTests.value = loadedLabTests; // Simpan data ke RxList
    } catch (e) {
      print("Error fetching lab tests: $e");
    } finally {
      isLoading.value = false; // Proses selesai
    }
  }

  Future<void> updateLabTestsData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Ambil semua dokumen dari koleksi "labTests"
      final querySnapshot = await firestore.collection('labTests').get();

      for (var doc in querySnapshot.docs) {
        final labTestId = doc.id; // ID dokumen labTest

        // Tambahkan field "description" dan "address" ke setiap dokumen
        await firestore.collection('labTests').doc(labTestId).update({
          "description":
              "Deskripsi lengkap terkait tes ${doc['test'] ?? 'Lab'} yang dilakukan di ${doc['hospital'] ?? 'Rumah Sakit'}.",
          "address":
              "Jl. Contoh Alamat No. ${doc['hospital'] == 'RS Hermina' ? '45' : '12'}, ${doc['location']['district'] ?? 'Unknown'}, ${doc['location']['city'] ?? 'Unknown'}",
          "operasionalHours": {
            "start": "08:00",
            "end": "20:00",
          },
          "schedule": [
            {
              "start": "08:00",
              "end": "10:00",
              "type": "Pagi",
            },
            {
              "start": "13:00",
              "end": "15:00",
              "type": "Siang",
            },
            {
              "start": "15:00",
              "end": "17:00",
              "type": "Sore",
            }
          ]
        });
      }

      print("Data labTests berhasil diperbarui!");
    } catch (e) {
      print("Error updating labTests data: $e");
    }
  }
}
