import 'package:flutter/material.dart';
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
        title: Text(
          'Tambah Klinik',
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
            // Input Nama Klinik
            CustomTextfield(
              hint: 'Nama Klinik',
              textController: controller.clinicNameController,
              icon: Icons.local_hospital,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Input Alamat Klinik
            CustomTextfield(
              hint: 'Alamat Klinik',
              textController: controller.clinicAddressController,
              icon: Icons.location_on,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Input Kota Klinik
            CustomTextfield(
              hint: 'Kota',
              textController: controller.clinicCityController,
              icon: Icons.location_city,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Input Kecamatan Klinik
            CustomTextfield(
              hint: 'Kecamatan',
              textController: controller.clinicDistrictController,
              icon: Icons.map,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Input URL Gambar Klinik
            CustomTextfield(
              hint: 'URL Gambar Klinik',
              textController: controller.clinicImageController,
              icon: Icons.image,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Input Hari
            CustomTextfield(
              hint: 'Hari (Senin - Minggu)',
              textController: controller.scheduleDayController,
              icon: Icons.calendar_today,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Input Jam Mulai
            CustomTextfield(
              hint: 'Jam Mulai (HH:MM)',
              textController: controller.scheduleStartController,
              icon: Icons.access_time,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Input Jam Selesai
            CustomTextfield(
              hint: 'Jam Selesai (HH:MM)',
              textController: controller.scheduleEndController,
              icon: Icons.access_time,
              borderColor: AppColors.blueColor,
            ),
            SizedBox(height: 16),

            // Tampilkan Daftar Jadwal
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.schedules.length,
                itemBuilder: (context, index) {
                  final schedule = controller.schedules[index];
                  return ListTile(
                    title: Text(
                        '${schedule['day']} : ${schedule['startTime']} - ${schedule['endTime']}'),
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

            // Tambah Jadwal Button
            ElevatedButton(
              onPressed: () {
                // Ambil nilai dari controller
                String day = controller.scheduleDayController.text;
                String startTime = controller.scheduleStartController.text;
                String endTime = controller.scheduleEndController.text;

                // Panggil method untuk menambah jadwal
                controller.addSchedule(day, startTime, endTime);
              },
              child: Text('Tambah Jadwal'),
            ),
            SizedBox(height: 30),

            // Tombol Tambah Dokter
            ElevatedButton(
              onPressed: () {
                controller.saveClinicData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueColor,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Tambah Klinik',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
