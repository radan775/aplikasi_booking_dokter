import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BeritaController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _storage = GetStorage();

  RxList<Map<String, dynamic>> newsList = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;
  RxString userRole = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchNewsFromFirestore();
    userRole.value = _storage.read('role') ?? '';
  }

  bool get isAdmin => userRole.value == 'admin';

  Future<void> fetchNewsFromFirestore() async {
    try {
      isLoading.value = true;
      final querySnapshot = await _firestore.collection('news').get();
      final List<Map<String, dynamic>> loadedNews =
          querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'title': data['title'] ?? '',
          'image': data['image'] ?? '',
          'url': data['url'] ?? '',
        };
      }).toList();

      newsList.value = loadedNews; // Simpan data ke RxList
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      isLoading.value = false; // Hapus status loading
    }
  }

  Future<void> deleteNews(String documentId) async {
    try {
      // Hapus dokumen berdasarkan ID
      await _firestore.collection('news').doc(documentId).delete();

      // Hapus dari local list
      newsList.removeWhere((news) => news['id'] == documentId);

      // Tampilkan snackbar sukses
      Get.snackbar(
        'Sukses',
        'Berita berhasil dihapus',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error deleting news: $e');
      Get.snackbar(
        'Error',
        'Gagal menghapus berita',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
