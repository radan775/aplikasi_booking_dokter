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
      body: RefreshIndicator(
        onRefresh: () => controller.fetchUserData(),
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
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
                          icon:
                              const Icon(Icons.edit, color: Colors.blueAccent),
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
                    enabled: false,
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
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextfield(
                          hint: "Tanggal/Bulan/Tahun",
                          textController: controller.birthDateController,
                          inputType: TextInputType.number,
                          enabled: false,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDate != null) {
                            controller.birthDateController.text =
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                          }
                        },
                      ),
                    ],
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
                                color: controller.selectedGender.value ==
                                        "Laki-laki"
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
                                color: controller.selectedGender.value ==
                                        "Perempuan"
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

                  // Submit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Tampilkan dialog konfirmasi
                        showDialog(
                          context: Get.context!,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Konfirmasi Perubahan Profil',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blueColor,
                                ),
                              ),
                              content: Text(
                                'Apakah data yang diinputkan sudah benar?',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                ),
                              ),
                              actions: [
                                // Tombol Tidak
                                TextButton(
                                  onPressed: () {
                                    // Tutup dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Tidak',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // Tombol Sudah
                                ElevatedButton(
                                  onPressed: () {
                                    // Tutup dialog
                                    Navigator.of(context).pop();

                                    // Panggil method update profile
                                    controller.updateProfile();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blueColor,
                                  ),
                                  child: Text(
                                    'Sudah',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 40),
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
            );
          },
        ),
      ),
    );
  }
}
