import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BeritaController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> newsList = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchNewsFromFirestore();
  }

  Future<void> fetchNewsFromFirestore() async {
    try {
      isLoading.value = true;
      final querySnapshot = await _firestore.collection('news').get();
      final List<Map<String, dynamic>> loadedNews =
          querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
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
}
