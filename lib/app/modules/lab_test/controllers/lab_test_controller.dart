import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LabTestController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _storage = GetStorage();

  RxList<Map<String, dynamic>> labTests = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;
  RxString namalengkap = ''.obs;
  RxList<String> labTestTypes = <String>[].obs;
  RxString selectedLabTestType = ''.obs;
  RxList<Map<String, dynamic>> filteredLabTests = <Map<String, dynamic>>[].obs;
  RxString searchQuery = ''.obs;
  final searchController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  RxBool isListening = false.obs;
  RxString userAddress = 'Mencari lokasi...'.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchLabTests();
    await getCurrentLocation();
    filteredLabTests.value = labTests;
  }

  @override
  void onClose() {
    _speechToText.cancel();
    super.onClose();
  }

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
            searchLabTests(result.recognizedWords);

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

  // Method untuk menghentikan voice search
  void stopVoiceSearch() {
    _speechToText.stop();
    isListening.value = false;
  }

  void searchLabTests(String query) {
    searchQuery.value = query.toLowerCase();

    if (query.isEmpty) {
      // Jika query kosong, kembalikan ke kondisi sebelumnya
      filteredLabTests.value = labTests;
    } else {
      // Filter berdasarkan nama rumah sakit, jenis test, alamat, atau lokasi
      filteredLabTests.value = labTests.where((labTest) {
        // Cek nama rumah sakit
        bool matchHospital = labTest['hospital']
            .toString()
            .toLowerCase()
            .contains(searchQuery.value);

        // Cek jenis test
        bool matchTest = labTest['test']
            .toString()
            .toLowerCase()
            .contains(searchQuery.value);

        // Cek alamat
        bool matchAddress = labTest['address']
            .toString()
            .toLowerCase()
            .contains(searchQuery.value);

        bool matchLocation = labTest['location']['district']
                .toString()
                .toLowerCase()
                .contains(searchQuery.value) ||
            labTest['location']['city']
                .toString()
                .toLowerCase()
                .contains(searchQuery.value);

        return matchHospital || matchTest || matchAddress || matchLocation;
      }).toList();
    }
  }

  void filterLabTestByTest(String test) {
    searchController.clear();
    searchQuery.value = '';
    if (selectedLabTestType.value == test) {
      // Jika specialty sama dengan yang sudah dipilih, reset filter
      selectedLabTestType.value = '';
      filteredLabTests.value = labTests;
    } else {
      // Set specialty baru
      selectedLabTestType.value = test;
      // Filter dokter berdasarkan specialty
      filteredLabTests.value =
          labTests.where((labTest) => labTest['test'] == test).toList();
    }
  }

  void extractUniqueLabTest() {
    Set<String> uniqueSpecialties = {};
    for (var test in labTests) {
      String specialty = test['test'];
      if (specialty.isNotEmpty) {
        uniqueSpecialties.add(specialty);
      }
    }
    labTestTypes.value = uniqueSpecialties.toList();
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

  Future<void> fetchLabTests() async {
    try {
      isLoading.value = true;
      await fetchUserData();
      final querySnapshot = await _firestore.collection('labTests').get();
      final List<Map<String, dynamic>> loadedLabTests =
          querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          "id": doc.id,
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

      labTests.value = loadedLabTests;
      extractUniqueLabTest();
      filterLabTestByTest(selectedLabTestType.value);
      selectedLabTestType.value = '';
    } catch (e) {
      print("Error fetching lab tests: $e");
    } finally {
      isLoading.value = false; // Proses selesai
    }
  }

  Future<void> updateLabTestsData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore.collection('labTests').get();

      for (var doc in querySnapshot.docs) {
        final labTestId = doc.id;

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
