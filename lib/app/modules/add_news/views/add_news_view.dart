import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/add_news/controllers/add_news_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';

class AddNewsView extends GetView<AddNewsController> {
  const AddNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: Text(
          'Tambah Berita',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Preview Gambar dari URL
            Obx(() {
              return controller.imageUrl.value.isNotEmpty
                  ? Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(controller.imageUrl.value),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Masukkan URL Gambar',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
            }),
            SizedBox(height: 20),

            // Input URL Gambar
            CustomTextfield(
              hint: 'URL Gambar Berita',
              textController: controller.imageUrlController,
              icon: Icons.image_outlined,
              borderColor: AppColors.blueColor,
              inputType: TextInputType.url,
              onChanged: (value) {
                // Gunakan method dari controller
                controller.updateImageUrl(value);
              },
            ),
            SizedBox(height: 20),

            CustomTextfield(
              hint: 'Judul Berita',
              textController: controller.titleController,
              icon: Icons.title,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 20),

            // Input Link
            CustomTextfield(
              hint: 'Link Berita',
              textController: controller.linkController,
              icon: Icons.link,
              borderColor: AppColors.blueColor,
              inputType: TextInputType.url,
            ),
            SizedBox(height: 30),

            // Tombol Unggah
            Obx(() {
              return ElevatedButton(
                onPressed:
                    controller.isLoading.value ? null : controller.uploadNews,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Ubah radius sesuai keinginan
                  ),
                ),
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Unggah Berita',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
