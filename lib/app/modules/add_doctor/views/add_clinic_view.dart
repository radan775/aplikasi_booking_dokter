import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/add_doctor/controllers/add_doctor_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';

class AddClinicView extends GetView<AddDoctorController> {
  const AddClinicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          'Tambah Klinik',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextfield(
              hint: 'Nama Klinik',
              textController: controller.clinicNameController,
              icon: Icons.local_hospital,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'Alamat Klinik',
              textController: controller.clinicAddressController,
              icon: Icons.location_on,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'Kota',
              textController: controller.clinicCityController,
              icon: Icons.location_city,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'Kecamatan',
              textController: controller.clinicDistrictController,
              icon: Icons.map,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'URL Gambar Klinik',
              textController: controller.clinicImageController,
              icon: Icons.image,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'Hari (Senin - Minggu)',
              textController: controller.scheduleDayController,
              icon: Icons.calendar_today,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'Jam Mulai (HH:MM)',
              textController: controller.scheduleStartController,
              icon: Icons.access_time,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'Jam Selesai (HH:MM)',
              textController: controller.scheduleEndController,
              icon: Icons.access_time,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.schedules.length,
                itemBuilder: (context, index) {
                  final schedule = controller.schedules[index];
                  final day = schedule.keys.first;
                  return ListTile(
                    title: Text(
                      '$day : ${schedule[day][0]["startTime"]} - ${schedule[day][0]["endTime"]}',
                      style: TextStyle(fontSize: AppSizes.fontSize12),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: AppColors.redColor,
                        size: AppSizes.iconSize25,
                      ),
                      onPressed: () {
                        controller.removeSchedule(index);
                      },
                    ),
                  );
                },
              );
            }),
            ElevatedButton(
              onPressed: () {
                String day = controller.scheduleDayController.text;
                String startTime = controller.scheduleStartController.text;
                String endTime = controller.scheduleEndController.text;
                controller.addSchedule(day, startTime, endTime);
              },
              child: Text(
                'Tambah Jadwal',
                style: TextStyle(fontSize: AppSizes.fontSize14),
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox24),
            ElevatedButton(
              onPressed: () {
                controller.saveClinicData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueColor,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.paddingVertical15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
                ),
              ),
              child: Text(
                'Tambah Klinik',
                style: TextStyle(
                  fontSize: AppSizes.fontSize16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
