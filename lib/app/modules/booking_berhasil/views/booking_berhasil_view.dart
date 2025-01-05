import 'package:aplikasi_booking_dokter/app/data/consts/lotties.dart';
import 'package:aplikasi_booking_dokter/app/modules/booking_berhasil/controllers/booking_berhasil_controller.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';

class BookingBerhasilView extends GetView<BookingBerhasilController> {
  const BookingBerhasilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie Animasi Centang
              Lottie.asset(
                AppLotties.success,
                width: AppSizes.lottieWidth250,
                height: AppSizes.lottieHeight250,
                repeat: true,
              ),
              SizedBox(height: AppSizes.heightSizeBox20),
              Text(
                "Berhasil Melakukan Pemesanan",
                style: TextStyle(
                  fontSize: AppSizes.fontSize24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blueColor,
                ),
              ),

              SizedBox(height: AppSizes.heightSizeBox10),

              Text(
                controller.tipeLayanan.value,
                style: TextStyle(
                  fontSize: AppSizes.fontSize18,
                  color: AppColors.greyColor,
                ),
              ),

              SizedBox(height: AppSizes.heightSizeBox20),

              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingHorizontal20,
                    vertical: AppSizes.paddingVertical10),
                decoration: BoxDecoration(
                  color: AppColors.grey200,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius10),
                ),
                child: Text(
                  controller.kodePemesanan.value,
                  style: TextStyle(
                    fontSize: AppSizes.fontSize22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueColor,
                    letterSpacing: 2,
                  ),
                ),
              ),

              SizedBox(height: AppSizes.heightSizeBox30),
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(Routes.BOTTOM_NAVBAR);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: AppSizes.paddingVertical15),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadius10),
                  ),
                ),
                child: Text(
                  "Kembali ke Beranda",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize16,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
