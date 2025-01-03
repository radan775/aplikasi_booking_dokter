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
        title: Text(
          'Tambah Lab Test',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nama Rumah Sakit
            CustomTextfield(
              hint: 'Nama Rumah Sakit',
              textController: controller.hospitalController,
              icon: Icons.local_hospital,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Alamat
            CustomTextfield(
              hint: 'Alamat Rumah Sakit',
              textController: controller.addressController,
              icon: Icons.location_on,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Lokasi (Kota & Kecamatan)
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
                SizedBox(width: 16),
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
            SizedBox(height: 16),

            // Deskripsi
            CustomTextfield(
              hint: 'Deskripsi Lab Test',
              textController: controller.descriptionController,
              icon: Icons.description,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Image URL
            CustomTextfield(
              hint: 'URL Gambar Rumah Sakit',
              textController: controller.imageUrlController,
              icon: Icons.image,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Harga
            CustomTextfield(
              hint: 'Harga Lab Test',
              textController: controller.priceController,
              icon: Icons.money,
              borderColor: AppColors.blueColor,
              inputType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Jam Operasional
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
                SizedBox(width: 16),
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
            SizedBox(height: 16),

            // Jenis Tes
            CustomTextfield(
              hint: 'Jenis Tes',
              textController: controller.testController,
              icon: Icons.medical_services,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Jadwal
            Text(
              'Tambah Jadwal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),

            // Input Jadwal
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
                SizedBox(width: 16),
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
            SizedBox(height: 16),

            // Tombol Tambah Jadwal
            ElevatedButton(
              onPressed: controller.addSchedule,
              child: Text('Tambah Jadwal'),
            ),
            SizedBox(height: 16),
            Text(
              'Daftar Jadwal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.schedules.length,
                itemBuilder: (context, index) {
                  final schedule = controller.schedules[index];
                  return ListTile(
                    title: Text(
                      '${schedule['start']} - ${schedule['end']} (${schedule['type']})',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.removeSchedule(index);
                      },
                    ),
                  );
                },
              );
            }),

            // Tombol Unggah
            Obx(() {
              return ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.uploadLabTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Tambah Lab Test',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
