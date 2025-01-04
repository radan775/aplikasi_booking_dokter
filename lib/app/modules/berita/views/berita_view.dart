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
        title: Text(
          'Berita',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          // Tampilkan indikator loading saat data sedang diambil
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.newsList.isEmpty) {
          // Tampilkan pesan jika data kosong
          return Center(
            child: Text("No news available."),
          );
        }

        // Tampilkan data berita setelah selesai diambil
        return RefreshIndicator(
          onRefresh: controller.fetchNewsFromFirestore,
          child: ListView.builder(
            padding: EdgeInsets.all(AppSizes.paddingAll10),
            itemCount: controller.newsList.length,
            itemBuilder: (context, index) {
              final news = controller.newsList[index];
              if (controller.isAdmin) {
                return Dismissible(
                  key: Key(news['id']),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    // Tampilkan dialog konfirmasi
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Hapus Berita',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.blueColor,
                              fontSize: AppSizes.fontSize18,
                            ),
                          ),
                          content: Text(
                            'Apakah Anda yakin ingin menghapus berita ini?',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: AppSizes.fontSize12,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                'Batal',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.fontSize14,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                'Hapus',
                                style: TextStyle(
                                  color: AppColors.blueColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.fontSize14,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingHorizontal20),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: AppSizes.iconSize30,
                    ),
                  ),
                  onDismissed: (direction) {
                    // Hapus berita
                    controller.deleteNews(news['id']);
                  },
                  child: _buildNewsCard(news, context),
                );
              }
              // Jika bukan admin, tampilkan card biasa
              else {
                return _buildNewsCard(news, context);
              }
            },
          ),
        );
      }),
      floatingActionButton: Obx(() {
        if (controller.isAdmin) {
          return FloatingActionButton.extended(
            heroTag: 'add_news',
            onPressed: () async {
              final result = await Get.toNamed(Routes.ADD_NEWS);
              if (result == true) {
                await controller.fetchNewsFromFirestore();
              }
            },
            backgroundColor: AppColors.blueColor,
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: AppSizes.iconSize28,
            ),
            label: Text(
              'Tambah Berita',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.fontSize14,
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      }),
    );
  }

  Widget _buildNewsCard(Map<String, dynamic> news, BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.INI_WEBVIEW, arguments: news['url']);
      },
      borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
      child: Card(
        margin: EdgeInsets.only(bottom: AppSizes.marginBottom10),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingAll12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gambar
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
                child: Image.network(
                  news['image']!,
                  width: AppSizes.imageWidth80,
                  height: AppSizes.imageHeight80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: AppSizes.imageWidth80,
                      height: AppSizes.imageHeight80,
                      color: Colors.grey,
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: AppSizes.widthSizeBox10),
              // Informasi Berita
              Expanded(
                child: Text(
                  news['title']!,
                  style: TextStyle(
                    fontSize: AppSizes.fontSize16,
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
  }
}
