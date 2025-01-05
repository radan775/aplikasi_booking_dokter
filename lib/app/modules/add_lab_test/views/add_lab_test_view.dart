import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/add_lab_test/controllers/add_lab_test_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';

class AddLabTestView extends GetView<AddLabTestController> {
  const AddLabTestView({super.key});

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
          'Tambah Lab Test',
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
              hint: 'Nama Rumah Sakit',
              textController: controller.hospitalController,
              icon: Icons.local_hospital,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'Alamat Rumah Sakit',
              textController: controller.addressController,
              icon: Icons.location_on,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    hint: 'Kota',
                    textController: controller.cityController,
                    icon: Icons.location_city,
                    borderColor: AppColors.blueColor,
                  ),
                ),
                SizedBox(width: AppSizes.widthSizeBox16),
                Expanded(
                  child: CustomTextfield(
                    hint: 'Kecamatan',
                    textController: controller.districtController,
                    icon: Icons.map,
                    borderColor: AppColors.blueColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'Deskripsi Lab Test',
              textController: controller.descriptionController,
              icon: Icons.description,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'URL Gambar Rumah Sakit',
              textController: controller.imageUrlController,
              icon: Icons.image,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'Harga Lab Test',
              textController: controller.priceController,
              icon: Icons.money,
              borderColor: AppColors.blueColor,
              inputType: TextInputType.number,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    hint: 'Jam Buka (HH:MM)',
                    textController: controller.startHourController,
                    icon: Icons.access_time,
                    borderColor: AppColors.blueColor,
                  ),
                ),
                SizedBox(width: AppSizes.widthSizeBox16),
                Expanded(
                  child: CustomTextfield(
                    hint: 'Jam Tutup (HH:MM)',
                    textController: controller.endHourController,
                    icon: Icons.access_time,
                    borderColor: AppColors.blueColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            CustomTextfield(
              hint: 'Jenis Tes',
              textController: controller.testController,
              icon: Icons.medical_services,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Text(
              'Tambah Jadwal',
              style: TextStyle(
                fontSize: AppSizes.fontSize18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    hint: 'Jam Mulai (HH:MM)',
                    textController: controller.scheduleStartController,
                    icon: Icons.access_time_filled,
                    borderColor: AppColors.blueColor,
                  ),
                ),
                SizedBox(width: AppSizes.widthSizeBox16),
                Expanded(
                  child: CustomTextfield(
                    hint: 'Jam Selesai (HH:MM)',
                    textController: controller.scheduleEndController,
                    icon: Icons.access_time_filled_outlined,
                    borderColor: AppColors.blueColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            ElevatedButton(
              onPressed: controller.addSchedule,
              child: Text(
                'Tambah Jadwal',
                style: TextStyle(
                  fontSize: AppSizes.fontSize14,
                ),
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox16),
            Text(
              'Daftar Jadwal',
              style: TextStyle(
                fontSize: AppSizes.fontSize18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: AppSizes.heightSizeBox8),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.schedules.length,
                itemBuilder: (context, index) {
                  final schedule = controller.schedules[index];
                  return ListTile(
                    title: Text(
                      '${schedule['start']} - ${schedule['end']} (${schedule['type']})',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppSizes.fontSize14,
                        color: AppColors.textColor,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: AppColors.redColor,
                        size: AppSizes.iconSize28,
                      ),
                      onPressed: () {
                        controller.removeSchedule(index);
                      },
                    ),
                  );
                },
              );
            }),
            Obx(() {
              return ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.uploadLabTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueColor,
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizes.paddingVertical15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
                  ),
                ),
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: AppColors.whiteColor)
                    : Text(
                        'Tambah Lab Test',
                        style: TextStyle(
                          fontSize: AppSizes.fontSize16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
