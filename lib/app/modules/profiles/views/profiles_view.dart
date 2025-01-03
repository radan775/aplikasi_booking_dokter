import 'package:aplikasi_booking_dokter/app/data/consts/lists.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/profiles/controllers/profiles_controller.dart';

class ProfilesView extends GetView<ProfilesController> {
  const ProfilesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
          elevation: 0.0,
          title: AppStyles.bold(
            title: AppStrings.profiles,
            color: AppColors.whiteColor,
            size: AppSizes.size18,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async => await controller.fetchUserData(),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                _buildUserProfile(),
                const Divider(thickness: 1, color: Colors.grey),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.settingsList.length,
                    itemBuilder: (context, index) =>
                        _buildSettingsOption(index),
                  ),
                ),
              ],
            );
          }),
        ));
  }

  Widget _buildUserProfile() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.blueColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: controller.profileImage.value != null
                ? FileImage(controller.profileImage.value!)
                : AssetImage(AppAssets.imgSignup) as ImageProvider,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles.bold(
                    title: controller.userName.value.isEmpty
                        ? "Memuat Nama..."
                        : controller.userName.value,
                    size: 18,
                  ),
                  const SizedBox(height: 4),
                  AppStyles.normal(
                    title: controller.userEmail.value.isEmpty
                        ? "Memuat Email..."
                        : controller.userEmail.value,
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              final result = await Get.toNamed(Routes.CHANGE_PROFILE);
              if (result == true) {
                await controller.fetchUserData();
              }
            },
            icon: Icon(Icons.build, color: AppColors.blueColor),
            tooltip: "Edit Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOption(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: () => _handleSettingsOptionTap(index),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.blueColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            settingsListIcon[index],
            color: AppColors.blueColor,
          ),
        ),
        title: AppStyles.bold(title: controller.settingsList[index], size: 16),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }

  void _handleSettingsOptionTap(int index) {
    if (index == 0) {
      Get.toNamed(Routes.CHANGE_PASSWORD);
    } else if (index == 1) {
      Get.toNamed(Routes.TERM_CONDITION);
    } else if (index == 2) {
      Get.toNamed(Routes.HELP);
    } else if (index == 3) {
      Get.toNamed(Routes.ABOUT);
    } else if (index == 4) {
      controller.signOut();
    }
  }
}
