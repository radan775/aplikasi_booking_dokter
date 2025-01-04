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
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: AppSizes.iconSize28,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Syarat dan Ketentuan',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Syarat dan Ketentuan Penggunaan",
              style: TextStyle(
                fontSize: AppSizes.fontSize20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Text(
              "1. Pengantar",
              style: TextStyle(
                fontSize: AppSizes.fontSize16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Text(
              "Aplikasi ini dirancang untuk mempermudah pengguna dalam melakukan reservasi dokter secara online. Dengan menggunakan aplikasi ini, Anda setuju untuk mematuhi semua syarat dan ketentuan yang berlaku.",
              style: TextStyle(
                fontSize: AppSizes.fontSize14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Text(
              "2. Penggunaan Aplikasi",
              style: TextStyle(
                fontSize: AppSizes.fontSize16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Text(
              "Aplikasi ini hanya dapat digunakan untuk tujuan pribadi dan tidak untuk keperluan komersial. Anda bertanggung jawab atas semua informasi yang Anda berikan.",
              style: TextStyle(
                fontSize: AppSizes.fontSize14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Text(
              "3. Hak dan Kewajiban Pengguna",
              style: TextStyle(
                fontSize: AppSizes.fontSize16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Text(
              "Pengguna wajib memberikan informasi yang akurat saat melakukan reservasi. Kesalahan dalam informasi dapat mengakibatkan pembatalan reservasi.",
              style: TextStyle(
                fontSize: AppSizes.fontSize14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Text(
              "4. Privasi dan Keamanan",
              style: TextStyle(
                fontSize: AppSizes.fontSize16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Text(
              "Kami menjaga kerahasiaan data pribadi Anda sesuai dengan kebijakan privasi kami. Namun, kami tidak bertanggung jawab atas kebocoran data yang diakibatkan oleh pihak ketiga.",
              style: TextStyle(
                fontSize: AppSizes.fontSize14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Text(
              "5. Pembatalan dan Refund",
              style: TextStyle(
                fontSize: AppSizes.fontSize16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Text(
              "Pembatalan reservasi dapat dilakukan sesuai dengan kebijakan yang telah ditentukan oleh masing-masing klinik atau rumah sakit.",
              style: TextStyle(
                fontSize: AppSizes.fontSize14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Text(
              "6. Perubahan Ketentuan",
              style: TextStyle(
                fontSize: AppSizes.fontSize16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Text(
              "Kami berhak mengubah syarat dan ketentuan ini kapan saja tanpa pemberitahuan sebelumnya. Disarankan untuk memeriksa syarat dan ketentuan secara berkala.",
              style: TextStyle(
                fontSize: AppSizes.fontSize14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox24),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueColor,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.paddingVertical16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadius10,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  "Kembali",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize16,
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
