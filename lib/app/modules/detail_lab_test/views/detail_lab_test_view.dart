import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_lab_test/controllers/detail_lab_test_controller.dart';

class DetailLabTestView extends GetView<DetailLabTestController> {
  const DetailLabTestView({super.key});

  @override
  Widget build(BuildContext context) {
    final labTestData = controller.labTestData;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppSizes.heightToolBar70,
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
            size: AppSizes.iconSize28,
          ),
          onPressed: () => Get.back(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labTestData['test'] ?? 'Unknown Test',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.fontSize18,
              ),
            ),
            Text(
              '${labTestData['currency']}${labTestData['price']}',
              style: TextStyle(
                color: AppColors.whiteColor70,
                fontSize: AppSizes.fontSize14,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLocationCard(labTestData),
            SizedBox(height: AppSizes.heightSizeBox16),
            _buildDescriptionCard(labTestData),
            SizedBox(height: AppSizes.heightSizeBox16),
            _buildScheduleCard(labTestData),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(Map<String, dynamic> labTestData) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lokasi Rumah Sakit",
              style: TextStyle(
                fontSize: AppSizes.fontSize16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    labTestData['image'] ?? '',
                    width: AppSizes.imageWidth80,
                    height: AppSizes.imageHeight80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: AppSizes.imageWidth80,
                      height: AppSizes.imageHeight80,
                      color: AppColors.grey300,
                      child: Icon(Icons.image_not_supported,
                          color: AppColors.greyColor),
                    ),
                  ),
                ),
                SizedBox(width: AppSizes.widthSizeBox16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        labTestData['hospital'] ?? 'Unknown Hospital',
                        style: TextStyle(
                          fontSize: AppSizes.fontSize16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppSizes.heightSizeBox8),
                      Text(
                        labTestData['address'] ?? 'Unknown Address',
                        style: TextStyle(
                          fontSize: AppSizes.fontSize14,
                          color: AppColors.greyColor,
                        ),
                      ),
                      SizedBox(height: AppSizes.heightSizeBox8),
                      Text(
                        'Jam Operasional: ${labTestData['operasionalHours']['start']} - ${labTestData['operasionalHours']['end']}',
                        style: TextStyle(
                          fontSize: AppSizes.fontSize14,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(Map<String, dynamic> labTestData) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Deskripsi",
              style: TextStyle(
                fontSize: AppSizes.fontSize16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            Text(
              labTestData['description'] ?? 'No description available.',
              style: TextStyle(
                fontSize: AppSizes.fontSize14,
                color: AppColors.black87,
                height: AppSizes.textHeight1_5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> labTestData) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jadwal",
              style: TextStyle(
                fontSize: AppSizes.fontSize16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            Obx(() {
              if (controller.selectedDateText.value.isEmpty) {
                return ElevatedButton(
                  onPressed: () => controller.pickDate(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.transparentColor,
                    elevation: 0,
                    minimumSize: Size(
                      double.infinity,
                      AppSizes.heightSizeButton45,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius8,
                      ),
                      side: BorderSide(
                        color: AppColors.blueColor,
                        width: AppSizes.widthBorderSide1_5,
                      ),
                    ),
                  ),
                  child: Text(
                    "Pilih Tanggal",
                    style: TextStyle(
                      color: AppColors.blueColor,
                      fontSize: AppSizes.fontSize16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: AppSizes.paddingVertical12,
                    horizontal: AppSizes.paddingHorizontal16),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.blueColor,
                      width: AppSizes.widthBoxDecoration1_5),
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadius8,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.selectedDateText.value,
                      style: TextStyle(
                        color: AppColors.blueColor,
                        fontSize: AppSizes.fontSize16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.pickDate(),
                      child: Text(
                        "Ganti Tanggal",
                        style: TextStyle(
                          color: AppColors.redColor,
                          fontSize: AppSizes.fontSize14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: AppSizes.heightSizeBox16),
            ...List.generate(
              (labTestData['schedule'] as List?)?.length ?? 0,
              (index) {
                final schedule = (labTestData['schedule'] as List)[index]
                    as Map<String, dynamic>;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: AppSizes.paddingBottom8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              schedule['type'] ?? 'Unknown Type',
                              style: TextStyle(
                                fontSize: AppSizes.fontSize14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: AppSizes.heightSizeBox4),
                            Text(
                              '${schedule['start']} - ${schedule['end']}',
                              style: TextStyle(
                                fontSize: AppSizes.fontSize14,
                                color: AppColors.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.buatJanji(
                              schedule['start'], schedule['end']);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.greenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSizes.borderRadius8),
                          ),
                        ),
                        child: Text(
                          "Buat Janji",
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: AppSizes.fontSize16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
