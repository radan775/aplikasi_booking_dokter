import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/term_condition/controllers/term_condition_controller.dart';
import 'package:get/get.dart';

class TermConditionView extends GetView<TermConditionController> {
  const TermConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: const Text(
          "Syarat dan Ketentuan",
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
              "Syarat dan Ketentuan Penggunaan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "1. Pengantar",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Aplikasi ini dirancang untuk mempermudah pengguna dalam melakukan reservasi dokter secara online. Dengan menggunakan aplikasi ini, Anda setuju untuk mematuhi semua syarat dan ketentuan yang berlaku.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "2. Penggunaan Aplikasi",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Aplikasi ini hanya dapat digunakan untuk tujuan pribadi dan tidak untuk keperluan komersial. Anda bertanggung jawab atas semua informasi yang Anda berikan.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "3. Hak dan Kewajiban Pengguna",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Pengguna wajib memberikan informasi yang akurat saat melakukan reservasi. Kesalahan dalam informasi dapat mengakibatkan pembatalan reservasi.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "4. Privasi dan Keamanan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Kami menjaga kerahasiaan data pribadi Anda sesuai dengan kebijakan privasi kami. Namun, kami tidak bertanggung jawab atas kebocoran data yang diakibatkan oleh pihak ketiga.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "5. Pembatalan dan Refund",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Pembatalan reservasi dapat dilakukan sesuai dengan kebijakan yang telah ditentukan oleh masing-masing klinik atau rumah sakit.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "6. Perubahan Ketentuan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Kami berhak mengubah syarat dan ketentuan ini kapan saja tanpa pemberitahuan sebelumnya. Disarankan untuk memeriksa syarat dan ketentuan secara berkala.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  "Kembali",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
