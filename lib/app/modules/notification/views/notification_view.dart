import 'package:aplikasi_booking_dokter/app/data/consts/colors.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/fonts.dart';
import 'package:aplikasi_booking_dokter/app/modules/notification/controllers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

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
          'Notifikasi',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.notifications.isEmpty
            ? Center(
                child: Text(
                  "Belum ada notifikasi",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize16,
                    color: AppColors.greyColor,
                  ),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(AppSizes.paddingAll10),
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  final notification = controller.notifications[index];
                  return Card(
                    margin: EdgeInsets.only(
                      bottom: AppSizes.marginBottom10,
                    ),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius12,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        notification["title"] ?? "",
                        style: TextStyle(
                          fontSize: AppSizes.fontSize16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AppSizes.heightSizeBox6,
                          ),
                          Text(
                            notification["message"] ?? "",
                            style: TextStyle(
                              fontSize: AppSizes.fontSize14,
                              color: AppColors.greyColor,
                            ),
                          ),
                          SizedBox(height: AppSizes.heightSizeBox4),
                          Text(
                            notification["date"] ?? "",
                            style: TextStyle(
                              fontSize: AppSizes.fontSize12,
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.notifications_active,
                        color: AppColors.blueAccentColor,
                        size: AppSizes.iconSize28,
                      ),
                      onTap: () {
                        Get.snackbar(
                          "Notifikasi",
                          notification["message"] ?? "",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.blueAccentColor,
                          colorText: AppColors.whiteColor,
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
