import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_data_pasien/controllers/detail_data_pasien_controller.dart';
import 'package:get/get.dart';

class DetailDataPasienView extends GetView<DetailDataPasienController> {
  const DetailDataPasienView({super.key});

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
          'Lengkapi data pasien',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingAll12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius10),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.paddingAll16),
                child: Obx(() {
                  if (controller.selectedSchedule["type"] == 'doctor') {
                    if (controller.selectedDoctorData.value.isEmpty &&
                        controller.selectedClinicData.value.isEmpty) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dokter pilihan anda",
                          style: TextStyle(
                            fontSize: AppSizes.fontSize16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: AppSizes.heightSizeBox16),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: AppSizes.avatarRadius40,
                              backgroundImage: NetworkImage(
                                controller.selectedDoctorData.value['image'],
                              ),
                            ),
                            SizedBox(width: AppSizes.widthSizeBox16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.selectedDoctorData.value['name']}',
                                  style: TextStyle(
                                    fontSize: AppSizes.fontSize18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: AppSizes.heightSizeBox8),
                                Text(
                                  '${controller.selectedDoctorData.value['specialty']}',
                                  style: TextStyle(
                                    fontSize: AppSizes.fontSize14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.heightSizeBox12),
                        Divider(),
                        Text(
                          "Lokasi dan jadwal praktik",
                          style: TextStyle(
                            fontSize: AppSizes.fontSize16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: AppSizes.heightSizeBox8),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppSizes.borderRadius8,
                              ),
                              child: Image.network(
                                '${controller.selectedClinicData.value['clinicImage']}',
                                width: AppSizes.imageWidth80,
                                height: AppSizes.imageHeight80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: AppSizes.imageWidth80,
                                  height: AppSizes.imageHeight80,
                                  color: Colors.grey,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: AppSizes.widthSizeBox16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${controller.selectedClinicData.value['clinicName']}',
                                    style: TextStyle(
                                      fontSize: AppSizes.fontSize16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${controller.selectedClinicData.value['scheduleDay']}, ${controller.selectedClinicData.value['scheduleDate']}",
                                    style: TextStyle(
                                      fontSize: AppSizes.fontSize14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '${controller.selectedClinicData.value['scheduleTime']}',
                                    style: TextStyle(
                                      fontSize: AppSizes.fontSize14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Biaya: Rp${controller.selectedClinicData.value['fee']}",
                                    style: TextStyle(
                                      fontSize: AppSizes.fontSize16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    if (controller.selectedClinicData.value.isEmpty) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lokasi dan jadwal praktik",
                          style: TextStyle(
                            fontSize: AppSizes.fontSize16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: AppSizes.heightSizeBox8),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadius10),
                              child: Image.network(
                                '${controller.selectedClinicData.value['clinicImage']}',
                                width: AppSizes.imageWidth80,
                                height: AppSizes.imageHeight80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: AppSizes.imageWidth80,
                                  height: AppSizes.imageHeight80,
                                  color: Colors.grey,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: AppSizes.widthSizeBox16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${controller.selectedClinicData.value['name']}',
                                    style: TextStyle(
                                      fontSize: AppSizes.fontSize16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${controller.selectedClinicData.value['scheduleDay']}, ${controller.selectedClinicData.value['scheduleDate']}",
                                    style: TextStyle(
                                      fontSize: AppSizes.fontSize14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '${controller.selectedClinicData.value['scheduleTime']}',
                                    style: TextStyle(
                                      fontSize: AppSizes.fontSize14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Biaya: Rp${controller.selectedClinicData.value['fee']}",
                                    style: TextStyle(
                                      fontSize: AppSizes.fontSize16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.heightSizeBox6),
                        Row(
                          children: [
                            Text(
                              "Tes: ",
                              style: TextStyle(
                                fontSize: AppSizes.fontSize16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              controller.selectedClinicData.value['test'],
                              style: TextStyle(
                                fontSize: AppSizes.fontSize16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.blueColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius10),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.paddingAll16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      "Sebentar lagi selesai",
                      style: TextStyle(
                        fontSize: AppSizes.fontSize18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSizes.heightSizeBox8),
                    Text(
                      "Selesaikan proses buat janji dengan melengkapi data berikut:",
                      style: TextStyle(
                        fontSize: AppSizes.fontSize14,
                        color: Colors.grey,
                      ),
                    ),

                    Text(
                      "Apakah pasien sudah berobat di Rumah sakit ini?",
                      style: TextStyle(
                        fontSize: AppSizes.fontSize16,
                      ),
                    ),
                    SizedBox(height: AppSizes.heightSizeBox8),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.selectedVisitStatus.value == "Ya"
                                        ? AppColors.blueColor
                                        : Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.borderRadius10,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                controller.selectedVisitStatus.value = "Ya";
                              },
                              child: Text(
                                "Ya, sudah pernah",
                                style: TextStyle(
                                  color: controller.selectedVisitStatus.value ==
                                          "Ya"
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: AppSizes.fontSize14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSizes.widthSizeBox8),
                        Expanded(
                          child: Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.selectedVisitStatus.value ==
                                            "Tidak"
                                        ? AppColors.blueColor
                                        : Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.borderRadius10,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                controller.selectedVisitStatus.value = "Tidak";
                              },
                              child: Text(
                                "Belum pernah",
                                style: TextStyle(
                                  color: controller.selectedVisitStatus.value ==
                                          "Tidak"
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: AppSizes.fontSize14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.heightSizeBox10),

                    // Metode pembayaran
                    Text(
                      "Metode pembayaran",
                      style: TextStyle(
                        fontSize: AppSizes.fontSize16,
                      ),
                    ),
                    SizedBox(height: AppSizes.heightSizeBox8),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.selectedPaymentMethod.value ==
                                            "Dana Pribadi"
                                        ? AppColors.blueColor
                                        : Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.borderRadius10,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                controller.selectedPaymentMethod.value =
                                    "Dana Pribadi";
                              },
                              child: Text(
                                "Dana Pribadi",
                                style: TextStyle(
                                  color:
                                      controller.selectedPaymentMethod.value ==
                                              "Dana Pribadi"
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: AppSizes.fontSize14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSizes.widthSizeBox8),
                        Expanded(
                          child: Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.selectedPaymentMethod.value ==
                                            "Asuransi"
                                        ? AppColors.blueColor
                                        : Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.borderRadius10,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                controller.selectedPaymentMethod.value =
                                    "Asuransi";
                              },
                              child: Text(
                                "Asuransi",
                                style: TextStyle(
                                  color:
                                      controller.selectedPaymentMethod.value ==
                                              "Asuransi"
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: AppSizes.fontSize14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.heightSizeBox16),
                    ElevatedButton(
                      onPressed: () {
                        // Tampilkan dialog konfirmasi
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Konfirmasi Pemesanan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blueColor,
                                  fontSize: AppSizes.fontSize18,
                                ),
                              ),
                              content: Text(
                                'Apakah semua data sudah benar?',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: AppSizes.fontSize12,
                                ),
                              ),
                              actions: [
                                // Tombol Belum
                                TextButton(
                                  onPressed: () {
                                    // Tutup dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Belum',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.fontSize14,
                                    ),
                                  ),
                                ),
                                // Tombol Ya
                                ElevatedButton(
                                  onPressed: () {
                                    // Tutup dialog
                                    Navigator.of(context).pop();
                                    controller.selesaikanPemesanan();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blueColor,
                                  ),
                                  child: Text(
                                    'Ya',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.fontSize14,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueColor,
                        padding: EdgeInsets.symmetric(
                            vertical: AppSizes.paddingVertical16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius10,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Selesai dan buat janji",
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
            ),
          ],
        ),
      ),
    );
  }
}
