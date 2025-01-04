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
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Preview Gambar dari URL
            Obx(() {
              return controller.imageUrl.value.isNotEmpty
                  ? Container(
                      height: AppSizes.heightContainer200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius10,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(controller.imageUrl.value),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      height: AppSizes.heightContainer200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius10,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            size: AppSizes.iconSize50,
                            color: Colors.grey[400],
                          ),
                          SizedBox(
                            height: AppSizes.heightSizeBox10,
                          ),
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
            SizedBox(height: AppSizes.heightSizeBox20),

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
            SizedBox(height: AppSizes.heightSizeBox20),

            CustomTextfield(
              hint: 'Judul Berita',
              textController: controller.titleController,
              icon: Icons.title,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox20),

            // Input Link
            CustomTextfield(
              hint: 'Link Berita',
              textController: controller.linkController,
              icon: Icons.link,
              borderColor: AppColors.blueColor,
              inputType: TextInputType.url,
            ),
            SizedBox(height: AppSizes.heightSizeBox30),

            // Tombol Unggah
            Obx(() {
              return ElevatedButton(
                onPressed:
                    controller.isLoading.value ? null : controller.uploadNews,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueColor,
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizes.paddingVertical15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Unggah Berita',
                        style: TextStyle(
                          fontSize: AppSizes.fontSize16,
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
