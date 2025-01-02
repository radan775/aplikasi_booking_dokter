import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
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
        title: const Text(
          "Tentang Aplikasi",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Booking Dokter Online",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Aplikasi ini dirancang untuk membantu Anda memesan janji dengan dokter secara mudah dan cepat. Anda dapat memilih dokter, jadwal, dan lokasi yang sesuai dengan kebutuhan Anda.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            const Text(
              "Developer",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, color: AppColors.blueColor),
                const SizedBox(width: 8),
                const Text(
                  "radan775",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final url = Uri.parse("https://github.com/radan775");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  Get.snackbar(
                    "Error",
                    "Tidak dapat membuka tautan.",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Row(
                children: [
                  const Icon(Icons.link, color: AppColors.blueColor),
                  const SizedBox(width: 8),
                  Text(
                    "https://github.com/radan775",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.blueColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Fitur Aplikasi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "- Pemesanan janji dengan dokter.\n"
              "- Pemilihan lokasi dan jadwal praktik.\n"
              "- Metode pembayaran fleksibel.\n"
              "- Data pengguna terjamin aman.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
