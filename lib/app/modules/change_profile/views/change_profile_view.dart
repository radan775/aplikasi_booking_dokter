import 'package:aplikasi_booking_dokter/app/data/consts/colors.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/images.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
import 'package:aplikasi_booking_dokter/app/modules/change_profile/controllers/change_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  const ChangeProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ubah Profil",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.blueColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Photo
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          AppAssets.imgSignup,
                        ), // Placeholder image
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              // Logic for changing photo
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () {
                      // Tambahkan logika upload foto
                    },
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    label: const Text(
                      "Ubah Foto",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Full Name Field
            CustomTextfield(
              hint: "Nama Lengkap",
              textController: controller.nameController,
            ),
            const SizedBox(height: 16),

            // Phone Number Field
            CustomTextfield(
              hint: "Nomor HP",
              textController: controller.phoneController,
              inputType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            // Email Field
            CustomTextfield(
              hint: "Email",
              textController: controller.emailController,
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Age Field
            CustomTextfield(
              hint: "Umur",
              textController: controller.ageController,
              inputType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Birth Date Field
            CustomTextfield(
              hint: "Tanggal Lahir",
              textController: controller.birthDateController,
              icon: Icons.calendar_today,
              inputType: TextInputType.datetime,
            ),
            const SizedBox(height: 16),

            // Gender Field
            const Text(
              "Jenis Kelamin",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.selectedGender.value = "Laki-laki";
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: controller.selectedGender.value == "Laki-laki"
                              ? Colors.blueAccent
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Laki-laki",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.selectedGender.value = "Perempuan";
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: controller.selectedGender.value == "Perempuan"
                              ? Colors.blueAccent
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Perempuan",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // City Field
            CustomTextfield(
              hint: "Kota/Kabupaten",
              textController: controller.cityController,
            ),
            const SizedBox(height: 16),

            // KTP Number Field
            CustomTextfield(
              hint: "Nomor KTP/NIK",
              textController: controller.ktpController,
              inputType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Address Field
            CustomTextfield(
              hint: "Alamat sesuai KTP/SKTT",
              textController: controller.addressController,
            ),
            const SizedBox(height: 30),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.updateProfile();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
