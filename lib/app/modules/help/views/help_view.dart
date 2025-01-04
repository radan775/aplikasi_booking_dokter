import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/help/controllers/help_controller.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Bantuan",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bagaimana kami dapat membantu Anda?",
              style: TextStyle(
                fontSize: AppSizes.fontSize20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Text(
              "Pilih kategori bantuan yang sesuai dengan kebutuhan Anda.",
              style: TextStyle(
                  fontSize: AppSizes.fontSize14, color: Colors.black87),
            ),
            SizedBox(height: AppSizes.heightSizeBox24),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildHelpCard(
                  title: "Cara Membuat Janji",
                  description:
                      "Panduan langkah demi langkah untuk membuat janji dengan dokter.",
                  onTap: () {
                    Get.toNamed(Routes.HELP_DETAIL,
                        arguments: "Cara Membuat Janji");
                  },
                ),
                SizedBox(height: AppSizes.heightSizeBox16),
                _buildHelpCard(
                  title: "Masalah Pembayaran",
                  description:
                      "Informasi mengenai metode pembayaran, kegagalan transaksi, dan refund.",
                  onTap: () {
                    Get.toNamed(Routes.HELP_DETAIL,
                        arguments: "Masalah Pembayaran");
                  },
                ),
                SizedBox(height: AppSizes.heightSizeBox16),
                _buildHelpCard(
                  title: "Akun dan Keamanan",
                  description:
                      "Bantuan terkait akun, login, dan privasi Anda di aplikasi.",
                  onTap: () {
                    Get.toNamed(Routes.HELP_DETAIL,
                        arguments: "Akun dan Keamanan");
                  },
                ),
                SizedBox(height: AppSizes.heightSizeBox16),
                _buildHelpCard(
                  title: "Hubungi Kami",
                  description:
                      "Informasi kontak kami untuk bantuan lebih lanjut.",
                  onTap: () {
                    Get.toNamed(Routes.HELP_DETAIL, arguments: "Hubungi Kami");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCard(
      {required String title,
      required String description,
      required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius10),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(
            fontSize: AppSizes.fontSize16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: AppSizes.fontSize14,
            color: Colors.black87,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }
}
