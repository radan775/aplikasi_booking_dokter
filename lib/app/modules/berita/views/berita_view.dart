import 'package:aplikasi_booking_dokter/app/modules/berita/controllers/berita_controller.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class BeritaView extends GetView<BeritaController> {
  const BeritaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: const Text(
          'Berita',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          // Tampilkan indikator loading saat data sedang diambil
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.newsList.isEmpty) {
          // Tampilkan pesan jika data kosong
          return const Center(
            child: Text("No news available."),
          );
        }

        // Tampilkan data berita setelah selesai diambil
        return RefreshIndicator(
          onRefresh: controller.fetchNewsFromFirestore,
          child: ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: controller.newsList.length,
            itemBuilder: (context, index) {
              final news = controller.newsList[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.INI_WEBVIEW, arguments: news['url']);
                },
                borderRadius: BorderRadius.circular(12), // Efek ripple
                child: Card(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Gambar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            news['image']!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Informasi Berita
                        Expanded(
                          child: Text(
                            news['title']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
