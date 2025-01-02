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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Bantuan",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bagaimana kami dapat membantu Anda?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Pilih kategori bantuan yang sesuai dengan kebutuhan Anda.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                const SizedBox(height: 16),
                _buildHelpCard(
                  title: "Masalah Pembayaran",
                  description:
                      "Informasi mengenai metode pembayaran, kegagalan transaksi, dan refund.",
                  onTap: () {
                    Get.toNamed(Routes.HELP_DETAIL,
                        arguments: "Masalah Pembayaran");
                  },
                ),
                const SizedBox(height: 16),
                _buildHelpCard(
                  title: "Akun dan Keamanan",
                  description:
                      "Bantuan terkait akun, login, dan privasi Anda di aplikasi.",
                  onTap: () {
                    Get.toNamed(Routes.HELP_DETAIL,
                        arguments: "Akun dan Keamanan");
                  },
                ),
                const SizedBox(height: 16),
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }
}
