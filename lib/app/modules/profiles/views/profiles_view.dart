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
          size: AppSizes.fontSize18,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => await controller.fetchUserData(),
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                _buildUserProfile(),
                Divider(
                  thickness: AppSizes.deviderThickness1,
                  color: Colors.grey,
                ),
                SizedBox(height: AppSizes.heightSizeBox20),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.settingsList.length,
                    itemBuilder: (context, index) =>
                        _buildSettingsOption(index),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingAll16),
      decoration: BoxDecoration(
        color: AppColors.blueColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadius12,
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.marginHorizontal16,
        vertical: AppSizes.marginVertical8,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSizes.avatarRadius30,
            backgroundImage: controller.profileImage.value != null
                ? FileImage(controller.profileImage.value!)
                : AssetImage(AppAssets.imgSignup) as ImageProvider,
          ),
          SizedBox(width: AppSizes.widthSizeBox16),
          Expanded(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles.bold(
                    title: controller.userName.value.isEmpty
                        ? "Memuat Nama..."
                        : controller.userName.value,
                    size: AppSizes.fontSize18,
                  ),
                  SizedBox(height: 4),
                  AppStyles.normal(
                    title: controller.userEmail.value.isEmpty
                        ? "Memuat Email..."
                        : controller.userEmail.value,
                    size: AppSizes.fontSize14,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: AppSizes.marginRight8),
            child: IconButton(
              onPressed: () async {
                final result = await Get.toNamed(Routes.CHANGE_PROFILE);
                if (result == true) {
                  await controller.fetchUserData();
                }
              },
              icon: Icon(
                Icons.build,
                color: AppColors.blueColor,
                size: AppSizes.iconSize30,
              ),
              tooltip: "Edit Profile",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOption(int index) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.marginHorizontal16,
        vertical: AppSizes.marginVertical4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadius12,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: AppSizes.boxShadowSpreadRadius2,
            blurRadius: AppSizes.boxShadowBlurRadius5,
            offset: Offset(0, AppSizes.boxShadowOffsetY3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingAll4),
        child: ListTile(
          onTap: () => _handleSettingsOptionTap(index),
          leading: Container(
            padding: EdgeInsets.all(AppSizes.paddingAll8),
            decoration: BoxDecoration(
              color: AppColors.blueColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(
                AppSizes.borderRadius8,
              ),
            ),
            child: Icon(
              settingsListIcon[index],
              color: AppColors.blueColor,
              size: AppSizes.iconSize25,
            ),
          ),
          title: AppStyles.bold(
              title: controller.settingsList[index], size: AppSizes.fontSize16),
          trailing: Icon(Icons.arrow_forward_ios,
              size: AppSizes.iconSize16, color: Colors.grey),
        ),
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
