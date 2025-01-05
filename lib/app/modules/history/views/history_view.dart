import 'package:aplikasi_booking_dokter/app/data/consts/lotties.dart';
import 'package:aplikasi_booking_dokter/app/modules/history/controllers/history_controller.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: Text(
          'History',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => await controller.fetchHistory(),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.blueColor, // Tambahan untuk konsistensi warna
              ),
            );
          }

          if (controller.historyList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    AppLotties.empty_history,
                    width: AppSizes.lottieWidth200,
                    height: AppSizes.lottieHeight200,
                    repeat: true,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: AppSizes.heightSizeBox16),
                  Text(
                    'Tidak ada riwayat',
                    style: TextStyle(
                      fontSize: AppSizes.fontSize18,
                      color: AppColors.grey600,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(AppSizes.paddingAll10),
            itemCount: controller.historyList.length,
            itemBuilder: (context, index) {
              final history = controller.historyList[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.DETAIL_HISTORY, arguments: history);
                },
                child: Card(
                  margin: EdgeInsets.only(bottom: AppSizes.marginBottom10),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadius12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.paddingAll16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingHorizontal12,
                            vertical: AppSizes.paddingVertical4,
                          ),
                          decoration: BoxDecoration(
                            color: history['type'] == 'doctor'
                                ? AppColors.blueColor.withOpacity(0.2)
                                : AppColors.greenColor.withOpacity(0.2),
                            borderRadius:
                                BorderRadius.circular(AppSizes.borderRadius12),
                          ),
                          child: Text(
                            history['type'] == 'doctor' ? 'Doctor' : 'Lab Test',
                            style: TextStyle(
                              fontSize: AppSizes.fontSize14,
                              fontWeight: FontWeight.bold,
                              color: history['type'] == 'doctor'
                                  ? AppColors.blueColor
                                  : AppColors.greenColor,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizes.heightSizeBox10),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppSizes.borderRadius8),
                              child: Image.network(
                                history['type'] == 'doctor'
                                    ? history["doctorImage"]
                                    : history["clinicImage"],
                                width: AppSizes.imageWidth80,
                                height: AppSizes.imageHeight80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: AppSizes.imageWidth80,
                                    height: AppSizes.imageHeight80,
                                    color: AppColors.greyColor,
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: AppColors.whiteColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: AppSizes.heightSizeBox12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        history['type'] == 'doctor'
                                            ? Icons.person
                                            : Icons.local_hospital,
                                        size: AppSizes.iconSize18,
                                        color: history['type'] == 'doctor'
                                            ? AppColors.blueColor
                                            : AppColors.greenColor,
                                      ),
                                      SizedBox(width: AppSizes.widthSizeBox6),
                                      Expanded(
                                        child: Text(
                                          history['type'] == 'doctor'
                                              ? history["doctorName"]
                                              : history["clinicName"],
                                          style: TextStyle(
                                            fontSize: AppSizes.fontSize16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppSizes.heightSizeBox6),
                                  Row(
                                    children: [
                                      Icon(
                                        history['type'] == 'doctor'
                                            ? Icons.medical_services
                                            : Icons.science,
                                        size: AppSizes.iconSize18,
                                        color: AppColors.grey700,
                                      ),
                                      SizedBox(width: AppSizes.widthSizeBox6),
                                      Expanded(
                                        child: Text(
                                          history['type'] == 'doctor'
                                              ? history["doctorSpecialty"]
                                              : history["clinicTest"],
                                          style: TextStyle(
                                            fontSize: AppSizes.fontSize14,
                                            color: AppColors.grey700,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppSizes.heightSizeBox6),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: AppSizes.iconSize18,
                                        color: AppColors.grey700,
                                      ),
                                      SizedBox(width: AppSizes.widthSizeBox6),
                                      Expanded(
                                        child: Text(
                                          history["clinicAddress"],
                                          style: TextStyle(
                                            fontSize: AppSizes.fontSize14,
                                            color: AppColors.grey700,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: AppColors.grey300,
                          thickness: AppSizes.deviderThickness1,
                        ),
                        SizedBox(height: AppSizes.heightSizeBox5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: AppSizes.fontSize16,
                                  color: AppColors.blueColor,
                                ),
                                SizedBox(width: AppSizes.widthSizeBox4),
                                Text(
                                  "Date: ${history['selectedDay'].toString().upperCamelCase}, ${history['selectedDate']}",
                                  style: TextStyle(
                                    fontSize: AppSizes.fontSize14,
                                    color: AppColors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppSizes.heightSizeBox3),
                            Row(
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  size: AppSizes.iconSize16,
                                  color: AppColors.greenColor,
                                ),
                                SizedBox(width: AppSizes.widthSizeBox4),
                                Text(
                                  "Code: ${history['code']}",
                                  style: TextStyle(
                                    fontSize: AppSizes.fontSize14,
                                    color: AppColors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
