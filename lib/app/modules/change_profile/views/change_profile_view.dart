import 'package:aplikasi_booking_dokter/app/data/consts/colors.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/fonts.dart';
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
          'Ubah Profile',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchUserData(),
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(AppSizes.paddingAll16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Obx(() {
                              return CircleAvatar(
                                radius: AppSizes.avatarRadius50,
                                backgroundImage: controller
                                            .profileImage.value !=
                                        null
                                    ? FileImage(controller.profileImage.value!)
                                    : AssetImage(AppAssets.imgSignup)
                                        as ImageProvider,
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: AppSizes.heightSizeBox10),
                        TextButton.icon(
                          onPressed: () {
                            controller.showImageSourceDialog();
                          },
                          icon: Icon(Icons.edit,
                              color: AppColors.blueAccentColor),
                          label: Text(
                            "Ubah Foto",
                            style: TextStyle(color: AppColors.blueAccentColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizes.heightSizeBox20),
                  CustomTextfield(
                    hint: "Nama Lengkap",
                    textController: controller.nameController,
                  ),
                  SizedBox(height: AppSizes.heightSizeBox16),
                  CustomTextfield(
                    hint: "Nomor HP",
                    textController: controller.phoneController,
                    inputType: TextInputType.phone,
                  ),
                  SizedBox(height: AppSizes.heightSizeBox16),
                  CustomTextfield(
                    hint: "Email",
                    textController: controller.emailController,
                    inputType: TextInputType.emailAddress,
                    enabled: false,
                  ),
                  SizedBox(height: AppSizes.heightSizeBox16),
                  CustomTextfield(
                    hint: "Umur",
                    textController: controller.ageController,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: AppSizes.heightSizeBox16),
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
                        icon: Icon(
                          Icons.calendar_today,
                          size: AppSizes.iconSize28,
                        ),
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
                  SizedBox(height: AppSizes.heightSizeBox16),
                  Text(
                    "Jenis Kelamin",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.fontSize14,
                    ),
                  ),
                  SizedBox(height: AppSizes.heightSizeBox8),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.selectedGender.value = "Laki-laki";
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSizes.paddingVertical12,
                              ),
                              decoration: BoxDecoration(
                                color: controller.selectedGender.value ==
                                        "Laki-laki"
                                    ? AppColors.blueAccentColor
                                    : AppColors.greyColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadius8,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Laki-laki",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.fontSize12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppSizes.widthSizeBox10),
                      Expanded(
                        child: Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.selectedGender.value = "Perempuan";
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSizes.paddingVertical12,
                              ),
                              decoration: BoxDecoration(
                                color: controller.selectedGender.value ==
                                        "Perempuan"
                                    ? AppColors.blueAccentColor
                                    : AppColors.greyColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadius8,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Perempuan",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.fontSize12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.heightSizeBox16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: Get.context!,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Konfirmasi Perubahan Profil',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blueColor,
                                  fontSize: AppSizes.fontSize18,
                                ),
                              ),
                              content: Text(
                                'Apakah data yang diinputkan sudah benar?',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: AppSizes.fontSize12,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Tidak',
                                    style: TextStyle(
                                      color: AppColors.redColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.fontSize14,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    controller.updateProfile();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blueColor,
                                  ),
                                  child: Text(
                                    'Sudah',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
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
                          vertical: AppSizes.paddingVertical12,
                          horizontal: AppSizes.paddingHorizontal40,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius8,
                          ),
                        ),
                      ),
                      child: Text(
                        "Simpan Perubahan",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: AppSizes.fontSize16,
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
