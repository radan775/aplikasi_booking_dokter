import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/add_doctor/controllers/add_doctor_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';

class AddDoctorView extends GetView<AddDoctorController> {
  const AddDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: Text(
          'Tambah Dokter',
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Nama Dokter
            CustomTextfield(
              hint: 'Nama Dokter',
              textController: controller.nameController,
              icon: Icons.person,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),

            // Input Profil Dokter
            CustomTextfield(
              hint: 'Deskripsi Singkat',
              textController: controller.profileController,
              icon: Icons.description,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),

            // Input Spesialisasi
            CustomTextfield(
              hint: 'Spesialisasi',
              textController: controller.specialtyController,
              icon: Icons.medical_services,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),

            // Input Biaya
            CustomTextfield(
              hint: 'Biaya Konsultasi',
              textController: controller.feeController,
              icon: Icons.money,
              borderColor: AppColors.blueColor,
              inputType: TextInputType.number,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),

            // Input URL Gambar
            CustomTextfield(
              hint: 'URL Gambar Dokter',
              textController: controller.imageController,
              icon: Icons.image,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: AppSizes.heightSizeBox16),

            // Input Riwayat Pendidikan
            CustomTextfield(
              hint: 'Riwayat Pendidikan',
              textController: controller.educationController,
              icon: Icons.school,
              borderColor: AppColors.blueColor,
            ),
            ElevatedButton(
              onPressed: () {
                controller.addEducation(controller.educationController.text);
              },
              child: Text('Tambah Pendidikan'),
            ),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.educationList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.educationList[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.removeEducation(index);
                      },
                    ),
                  );
                },
              );
            }),
            SizedBox(height: AppSizes.heightSizeBox16),

            // Input Pengalaman
            CustomTextfield(
              hint: 'Pengalaman',
              textController: controller.experienceController,
              icon: Icons.work,
              borderColor: AppColors.blueColor,
            ),
            ElevatedButton(
              onPressed: () {
                controller.addExperience(controller.experienceController.text);
              },
              child: Text('Tambah Pengalaman'),
            ),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.experienceList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.experienceList[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.removeExperience(index);
                      },
                    ),
                  );
                },
              );
            }),
            SizedBox(height: AppSizes.heightSizeBox16),

            // Input Treatment
            CustomTextfield(
              hint: 'Treatment yang Dilakukan',
              textController: controller.treatmentsController,
              icon: Icons.assignment,
              borderColor: AppColors.blueColor,
            ),
            ElevatedButton(
              onPressed: () {
                controller.addTreatment(controller.treatmentsController.text);
              },
              child: Text('Tambah Treatment'),
            ),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.treatmentsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.treatmentsList[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.removeTreatment(index);
                      },
                    ),
                  );
                },
              );
            }),
            SizedBox(height: AppSizes.heightSizeBox30),

            // Tombol Selanjutnya
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Memastikan tombol memiliki jarak
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.validateDoctorInput()) {
                        Get.toNamed(Routes.ADD_DOCTOR_CLINIC);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueColor,
                      padding: EdgeInsets.symmetric(
                          vertical: AppSizes.paddingVertical15),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSizes.borderRadius8),
                      ),
                    ),
                    child: Text(
                      'Tambah Klinik',
                      style: TextStyle(
                        fontSize: AppSizes.fontSize16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: AppSizes
                        .widthSizeBox10), // Memberikan jarak antara tombol
                Expanded(
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null // Nonaktifkan tombol saat loading
                          : () async {
                              if (controller.validateDoctorInput()) {
                                await controller.uploadDoctorData();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueColor,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.borderRadius8),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Upload Data',
                              style: TextStyle(
                                fontSize: AppSizes.fontSize16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
