import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/lists.dart';
import 'package:aplikasi_booking_dokter/app/modules/profiles/controllers/profiles_controller.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';

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
      body: Column(
        children: [
          _buildUserProfile(),
          const Divider(thickness: 1, color: Colors.grey),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: controller.settingsList.length,
              itemBuilder: (context, index) => _buildSettingsOption(index),
            ),
          ),
        ],
      ),
    );
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
            backgroundImage: AssetImage(AppAssets.imgSignup),
          ),
          const SizedBox(width: 16),
          Expanded(
            // Gunakan Expanded untuk mengatur ruang agar fleksibel
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppStyles.bold(title: "Username", size: 18),
                const SizedBox(height: 4),
                AppStyles.normal(title: "user_email@gmail.com", size: 14),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.CHANGE_PROFILE);
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
