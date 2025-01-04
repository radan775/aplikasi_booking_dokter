import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/about/controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: Text(
          "Tentang Aplikasi",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking Dokter Online",
              style: TextStyle(
                fontSize: AppSizes.fontSize24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Text(
              "Aplikasi ini dirancang untuk membantu Anda memesan janji dengan dokter secara mudah dan cepat. Anda dapat memilih dokter, jadwal, dan lokasi yang sesuai dengan kebutuhan Anda.",
              style: TextStyle(
                fontSize: AppSizes.fontSize14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox24),
            Text(
              "Developer",
              style: TextStyle(
                fontSize: AppSizes.fontSize18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Row(
              children: [
                Icon(Icons.person, color: AppColors.blueColor),
                SizedBox(width: AppSizes.heightSizeBox8),
                Text(
                  "radan775",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Row(
              children: [
                Icon(Icons.link, color: AppColors.blueColor),
                SizedBox(width: AppSizes.widthSizeBox8),
                Text(
                  "https://github.com/radan775",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize14,
                    color: AppColors.blueColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.heightSizeBox24),
            Text(
              "Fitur Aplikasi",
              style: TextStyle(
                fontSize: AppSizes.fontSize18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Text(
              "- Pemesanan janji dengan dokter.\n"
              "- Pemilihan lokasi dan jadwal praktik.\n"
              "- Metode pembayaran fleksibel.\n"
              "- Data pengguna terjamin aman.",
              style: TextStyle(
                fontSize: AppSizes.fontSize14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
