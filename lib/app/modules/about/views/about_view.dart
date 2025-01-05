import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/about/controllers/about_controller.dart';
import 'package:get/get.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor, // Ganti dengan AppColors
            size: AppSizes.iconSize28,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Tentang',
          style: TextStyle(
            color: AppColors.whiteColor, // Ganti dengan AppColors
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
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
                color: AppColors.black87, // Ganti dengan AppColors
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
                Icon(Icons.person,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.heightSizeBox8),
                Text(
                  "Taufiq Ramadhan",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.format_list_numbered,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.heightSizeBox8),
                Text(
                  "202210370311208",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.link,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.widthSizeBox8),
                Text(
                  "https://github.com/radan775",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize14,
                    color: AppColors.blueColor, // Ganti dengan AppColors
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Row(
              children: [
                Icon(Icons.person,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.heightSizeBox8),
                Text(
                  "Hisyam Bima Ekhsantama",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.format_list_numbered,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.heightSizeBox8),
                Text(
                  "202210370311190",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.link,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.widthSizeBox8),
                Text(
                  "https://github.com/Softdrinks14",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize14,
                    color: AppColors.blueColor, // Ganti dengan AppColors
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Row(
              children: [
                Icon(Icons.person,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.heightSizeBox8),
                Text(
                  "Rahmatullah Akbar Prima",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.format_list_numbered,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.heightSizeBox8),
                Text(
                  "202210370311188",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.link,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.widthSizeBox8),
                Text(
                  "https://github.com/Arabmeme",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize14,
                    color: AppColors.blueColor, // Ganti dengan AppColors
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Row(
              children: [
                Icon(Icons.person,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.heightSizeBox8),
                Text(
                  "M. Haidar Afif Al Azizi",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.format_list_numbered,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.heightSizeBox8),
                Text(
                  "202210370311191",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.link,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.widthSizeBox8),
                Text(
                  "https://github.com/Hadarafif",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize14,
                    color: AppColors.blueColor, // Ganti dengan AppColors
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.heightSizeBox10),
            Text(
              "Figma Desain",
              style: TextStyle(
                fontSize: AppSizes.fontSize18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Row(
              children: [
                Icon(Icons.person,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.heightSizeBox8),
                Text(
                  "Bima Bhakti Brawijaya",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.format_list_numbered,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.heightSizeBox8),
                Text(
                  "202210370311168",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.link,
                    color: AppColors.blueColor), // Ganti dengan AppColors
                SizedBox(width: AppSizes.widthSizeBox8),
                Text(
                  "https://bit.ly/figmaMobile",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize14,
                    color: AppColors.blueColor, // Ganti dengan AppColors
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
                color: AppColors.black87, // Ganti dengan AppColors
              ),
            ),
          ],
        ),
      ),
    );
  }
}
