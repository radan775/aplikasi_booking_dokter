import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _storage = GetStorage();

  RxList<Map<String, dynamic>> doctors = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;
  RxString namalengkap = ''.obs;

  RxList<String> doctorTypes = <String>[].obs;
  RxString selectedDoctorType = ''.obs;
  RxList<Map<String, dynamic>> filteredDoctors = <Map<String, dynamic>>[].obs;
  RxString searchQuery = ''.obs;
  final searchController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  RxBool isListening = false.obs;
  RxString userAddress = 'Mencari lokasi...'.obs;
  RxString userRole = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchDoctors();
    await getCurrentLocation();
    userRole.value = _storage.read('role') ?? '';
    filteredDoctors.value = doctors;
  }

  @override
  void onClose() {
    _speechToText.cancel();
    super.onClose();
  }

  bool get isAdmin => userRole.value == 'admin';

  Future<void> getCurrentLocation() async {
    try {
      // Periksa izin lokasi
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        // Dapatkan posisi saat ini
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Konversi koordinat ke alamat
        await convertCoordinatesToAddress(position);
      } else {
        userAddress.value = 'Izin lokasi ditolak';
      }
    } catch (e) {
      userAddress.value = 'Gagal mendapatkan lokasi';
      print("Error getting location: $e");
    }
  }

  Future<void> convertCoordinatesToAddress(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        // Susun alamat dengan format yang lebih ringkas
        String address = '';

        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          address += '${place.subLocality}, ';
        }

        if (place.locality != null && place.locality!.isNotEmpty) {
          address += '${place.locality}, ';
        }

        if (place.subAdministrativeArea != null &&
            place.subAdministrativeArea!.isNotEmpty) {
          address += '${place.subAdministrativeArea}, ';
        }

        if (place.administrativeArea != null &&
            place.administrativeArea!.isNotEmpty) {
          address += place.administrativeArea!;
        }

        userAddress.value =
            address.isNotEmpty ? address : 'Lokasi tidak dikenali';
      } else {
        userAddress.value = 'Alamat tidak ditemukan';
      }
    } catch (e) {
      userAddress.value = 'Gagal menerjemahkan lokasi';
      print("Error converting coordinates: $e");
    }
  }

  Future<void> startVoiceSearch() async {
    // Minta izin mikropon
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      bool available = await _speechToText.initialize(
        onStatus: (status) {
          print('Speech status: $status');
        },
        onError: (error) {
          print('Speech error: $error');
          isListening.value = false;
        },
      );

      if (available) {
        isListening.value = true;
        _speechToText.listen(
          onResult: (result) {
            // Set text ke search controller
            searchController.text = result.recognizedWords;

            // Lakukan pencarian
            searchDoctors(result.recognizedWords);

            // Hentikan listening jika sudah final
            if (result.finalResult) {
              stopVoiceSearch();
            }
          },
          localeId: 'id_ID', // Gunakan bahasa Indonesia
        );
      }
    } else {
      Get.snackbar(
        'Izin Ditolak',
        'Izin menggunakan mikropon diperlukan',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void stopVoiceSearch() {
    _speechToText.stop();
    isListening.value = false;
  }

  void searchDoctors(String query) {
    searchQuery.value = query.toLowerCase();

    if (query.isEmpty) {
      filteredDoctors.value = doctors;
    } else {
      filteredDoctors.value = doctors.where((doctor) {
        // Cek nama dokter
        bool matchName =
            doctor['name'].toString().toLowerCase().contains(searchQuery.value);

        // Cek spesialisasi
        bool matchSpecialty = doctor['specialty']
            .toString()
            .toLowerCase()
            .contains(searchQuery.value);

        // Cek alamat klinik
        bool matchClinicAddress = doctor['clinics'].any((clinic) =>
            clinic['address']
                .toString()
                .toLowerCase()
                .contains(searchQuery.value) ||
            clinic['clinicName']
                .toString()
                .toLowerCase()
                .contains(searchQuery.value) ||
            clinic['district']
                .toString()
                .toLowerCase()
                .contains(searchQuery.value) ||
            clinic['city']
                .toString()
                .toLowerCase()
                .contains(searchQuery.value));

        return matchName || matchSpecialty || matchClinicAddress;
      }).toList();
    }
  }

  void filterDoctorsBySpecialty(String specialty) {
    searchController.clear();
    searchQuery.value = '';
    if (selectedDoctorType.value == specialty) {
      // Jika specialty sama dengan yang sudah dipilih, reset filter
      selectedDoctorType.value = '';
      filteredDoctors.value = doctors;
    } else {
      // Set specialty baru
      selectedDoctorType.value = specialty;
      // Filter dokter berdasarkan specialty
      filteredDoctors.value =
          doctors.where((doctor) => doctor['specialty'] == specialty).toList();
    }
  }

  void extractUniqueDoctorTypes() {
    Set<String> uniqueSpecialties = {};
    for (var doctor in doctors) {
      String specialty = doctor['specialty'];
      if (specialty.isNotEmpty) {
        uniqueSpecialties.add(specialty);
      }
    }
    doctorTypes.value = uniqueSpecialties.toList();
  }

  String formatFee(String currency, int fee) {
    final formatter = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: 0,
    );
    return "$currency${formatter.format(fee)}";
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      String? userId = _storage.read('userId');
      if (userId == null) {
        print('User ID tidak ditemukan');
        return;
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        namalengkap.value = userData['namalengkap'] ?? '';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengambil data profil',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchDoctors() async {
    try {
      isLoading.value = true;
      await fetchUserData();

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

      doctors.value = loadedDoctors;
      extractUniqueDoctorTypes();
      filterDoctorsBySpecialty(selectedDoctorType.value);
      selectedDoctorType.value = '';
    } catch (e) {
      print("Error fetching doctors: $e");
    } finally {
      isLoading.value = false;
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
