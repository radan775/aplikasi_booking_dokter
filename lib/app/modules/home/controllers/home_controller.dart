import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> doctors = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs; // Status loading

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

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchDoctors();

    //await updateDoctorsData();
  }

  String formatFee(String currency, int fee) {
    final formatter = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: 0,
    );
    return "$currency${formatter.format(fee)}";
  }

  Future<void> fetchDoctors() async {
    try {
      isLoading.value = true; // Mulai proses loading

      final querySnapshot = await _firestore.collection('doctors').get();

      final List<Map<String, dynamic>> loadedDoctors = [];

      for (var doc in querySnapshot.docs) {
        final data = doc.data();

        final clinicsSnapshot = await _firestore
            .collection('doctors')
            .doc(doc.id)
            .collection('clinics')
            .get();

        final clinics = clinicsSnapshot.docs.map((clinicDoc) {
          final clinicData = clinicDoc.data();
          return {
            "clinicId": clinicDoc.id,
            "clinicName": clinicData['clinic']['name'] ?? '',
            "district": clinicData['clinic']['district'] ?? '',
            "city": clinicData['clinic']['city'] ?? '',
            "address": clinicData['clinic']['address'] ?? '',
            "clinicImage": clinicData['clinic']['image'] ?? '',
            "fee": clinicData['clinic']['fee'] ?? 0,
            "schedule": clinicData['schedule'] ?? {},
          };
        }).toList();

        loadedDoctors.add({
          "id": doc.id,
          "name": data['name'] ?? '',
          "specialty": data['specialty'] ?? '',
          "currency": data['currency'] ?? 'Rp',
          "fee": data['fee'] ?? 0,
          "image": data['image'] ?? '',
          "treatments": data['treatments'] ?? [],
          "experiences": data['experiences'] ?? [],
          "education": data['education'] ?? [],
          "profile": data['profile'] ?? '',
          "clinics": clinics,
        });
      }

      doctors.value = loadedDoctors; // Simpan data ke RxList
    } catch (e) {
      print("Error fetching doctors: $e");
    } finally {
      isLoading.value = false; // Proses selesai
    }
  }

  Future<void> updateDoctorsData() async {
    try {
      isLoading.value = true; // Mulai proses loading

      // Ambil semua dokumen dari koleksi "doctors"
      final querySnapshot = await _firestore.collection('doctors').get();

      for (var doc in querySnapshot.docs) {
        final doctorId = doc.id; // ID dari dokumen dokter

        // Tentukan data dummy berdasarkan spesialisasi dokter
        final data = getDummyData(doc.data()['specialty']);

        // Perbarui dokumen utama dengan data baru
        await _firestore.collection('doctors').doc(doctorId).update({
          "treatments": data['treatments'],
          "experiences": data['experiences'],
          "education": data['education'],
          "profile":
              "Profil dokter yang sangat berpengalaman di bidang kesehatan gigi.",
        });

        // Tambahkan sub-collection "clinics" untuk setiap dokter
        for (var clinic in data['clinics']) {
          await _firestore
              .collection('doctors')
              .doc(doctorId)
              .collection('clinics')
              .add(clinic);
        }
      }

      print("Data berhasil diperbarui!");
    } catch (e) {
      print("Error updating doctors data: $e");
    } finally {
      isLoading.value = false; // Proses selesai
    }
  }

  Map<String, dynamic> getDummyData(String specialty) {
    switch (specialty.toLowerCase()) {
      case "gigi":
        return {
          "treatments": [
            "Cabut gigi",
            "Foto Panoramik Gigi",
            "Pembersihan gigi",
            "Pengobatan gigi sensitif",
            "Tambal gigi",
            "Scaling gigi"
          ],
          "experiences": [
            "RS Lavalette (2015-2019)",
            "RSIA Husada Bunda (2019-2023)"
          ],
          "education": [
            "Sarjana Kedokteran Gigi - Universitas Indonesia (2010)",
            "Spesialisasi Kedokteran Gigi Anak - Universitas Airlangga (2014)"
          ],
          "profile":
              "Profil dokter yang sangat berpengalaman di bidang kesehatan gigi.",
          "clinics": [
            {
              "clinic": {
                "name": "RSIA Puri Malang",
                "image": "https://placehold.jp/100x100.png",
                "district": "Blimbing",
                "city": "Kota Malang",
                "address": "Jl. Ahmad Yani No. 1, Blimbing, Kota Malang"
              },
              "schedule": {
                "senin": [
                  {"startTime": "16:00", "endTime": "19:00"}
                ],
                "selasa": [
                  {"startTime": "14:00", "endTime": "16:00"}
                ]
              }
            },
            {
              "clinic": {
                "name": "RSIA Husada Bunda",
                "district": "Sukun",
                "city": "Kota Malang",
                "image": "https://placehold.jp/100x100.png",
                "address": "Jl. Sudirman No. 5, Sukun, Kota Malang"
              },
              "schedule": {
                "rabu": [
                  {"startTime": "18:00", "endTime": "20:00"}
                ],
                "kamis": [
                  {"startTime": "19:00", "endTime": "21:00"}
                ]
              }
            }
          ]
        };
      case "kandungan":
        return {
          "treatments": [
            "Konsultasi kehamilan",
            "Konsultasi laktasi",
            "Konsultasi program hamil",
            "Kuret",
            "Operasi cesar",
            "Pap smear",
            "Suntik KB",
            "Implan KB",
            "Tes kehamilan"
          ],
          "experiences": [
            "RSIA Puri Malang (2010-2015)",
            "RS Lavalette (2015-2023)"
          ],
          "education": [
            "Sarjana Kedokteran - Universitas Gadjah Mada (2008)",
            "Spesialis Obstetri dan Ginekologi - Universitas Indonesia (2012)"
          ],
          "profile":
              "Profil dokter yang sangat berpengalaman di bidang kesehatan gigi.",
          "clinics": [
            {
              "clinic": {
                "name": "RS Lavalette",
                "district": "Klojen",
                "image": "https://placehold.jp/100x100.png",
                "city": "Kota Malang",
                "address": "Jl. Kawi No. 15, Klojen, Kota Malang"
              },
              "schedule": {
                "senin": [
                  {"startTime": "08:00", "endTime": "12:00"}
                ],
                "kamis": [
                  {"startTime": "09:00", "endTime": "11:00"}
                ]
              }
            },
            {
              "clinic": {
                "name": "RSIA Puri Malang",
                "district": "Blimbing",
                "city": "Kota Malang",
                "image": "https://placehold.jp/100x100.png",
                "address": "Jl. Ahmad Yani No. 1, Blimbing, Kota Malang"
              },
              "schedule": {
                "jumat": [
                  {"startTime": "10:00", "endTime": "13:00"}
                ],
                "sabtu": [
                  {"startTime": "14:00", "endTime": "16:00"}
                ]
              }
            }
          ]
        };
      default:
        return {
          "treatments": ["General consultation", "Health check-up"],
          "experiences": ["Clinic A (2010-2015)", "Clinic B (2015-2020)"],
          "education": [
            "Medical Degree - Universitas Indonesia (2005)",
            "Specialization - Universitas Airlangga (2010)"
          ],
          "profile":
              "Profil dokter yang sangat berpengalaman di bidang kesehatan gigi.",
          "clinics": [
            {
              "clinic": {
                "name": "Clinic A",
                "district": "District A",
                "city": "City A",
                "image": "https://placehold.jp/100x100.png",
                "address": "Jl. Example No. 1, District A, City A"
              },
              "schedule": {
                "senin": [
                  {"startTime": "09:00", "endTime": "11:00"}
                ]
              }
            }
          ]
        };
    }
  }
}
