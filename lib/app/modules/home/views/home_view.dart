import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/lotties.dart';
import 'package:aplikasi_booking_dokter/app/modules/home/controllers/home_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppSizes.heightToolBar70,
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => AppStyles.bold(
                  title:
                      "${AppStrings.welcome} ${controller.namalengkap.value}",
                  color: AppColors.whiteColor,
                  size: AppSizes.fontSize18,
                )),
            Obx(() => AppStyles.normal(
                  title: controller.userAddress.value,
                  color: AppColors.whiteColor.withOpacity(0.8),
                  size: AppSizes.fontSize12,
                )),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.paddingRight10),
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                color: AppColors.whiteColor,
                size: AppSizes.iconSize30,
              ),
              onPressed: () {
                Get.toNamed(Routes.NOTIFICATION);
              },
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
              child: SizedBox(
            width: AppSizes.loadingSize,
            height: AppSizes.loadingSize,
            child: CircularProgressIndicator(
              strokeWidth: AppSizes.strokeWidth3,
            ),
          ));
        }
        if (controller.doctors.isEmpty) {
          return Center(
            child: Text("No doctors available."),
          );
        }

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.paddingAll12),
              color: AppColors.blueColor,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      hint: AppStrings.searchDoctor,
                      borderColor: AppColors.whiteColor,
                      textColor: AppColors.whiteColor,
                      textController: controller.searchController,
                      onChanged: (value) {
                        controller.searchDoctors(value);
                      },
                    ),
                  ),
                  SizedBox(width: AppSizes.widthSizeBox10),
                  // Tambahkan tombol mikropon
                  Obx(() {
                    return IconButton(
                      icon: Icon(
                          controller.isListening.value
                              ? Icons.mic
                              : Icons.mic_none,
                          color: controller.isListening.value
                              ? AppColors.redColor
                              : AppColors.whiteColor,
                          size: AppSizes.iconSize30),
                      onPressed: () {
                        if (controller.isListening.value) {
                          // Jika sedang listening, hentikan
                          controller.stopVoiceSearch();
                        } else {
                          // Mulai voice search
                          controller.startVoiceSearch();
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
            // Horizontal ListView for Doctor Types
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal10,
                vertical: AppSizes.paddingVertical10,
              ),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles.bold(
                    title: "Doctors",
                    size: AppSizes.fontSize18,
                    color: AppColors.blueColor,
                  ),
                  SizedBox(
                    height: AppSizes.heightSizeBox33,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.doctorTypes.length,
                      itemBuilder: (context, index) {
                        return Obx(() {
                          final specialty = controller.doctorTypes[index];
                          final isSelected =
                              controller.selectedDoctorType.value == specialty;

                          return GestureDetector(
                            onTap: () {
                              controller.filterDoctorsBySpecialty(specialty);
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: AppSizes.marginRight8),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.paddingHorizontal16,
                                vertical: AppSizes.paddingVertical8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.blueColor
                                    : AppColors.blueColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadius20,
                                ),
                              ),
                              child: Center(
                                child: AppStyles.normal(
                                  title: specialty,
                                  size: AppSizes.fontSize14,
                                  color: isSelected
                                      ? AppColors.whiteColor
                                      : AppColors.blueColor,
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Doctor List
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.fetchDoctors,
                child: Obx(
                  () {
                    if (controller.filteredDoctors.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              AppLotties.search_not_found,
                              width: AppSizes.lottieWidth200,
                              height: AppSizes.lottieHeight200,
                              repeat: true,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: AppSizes.heightSizeBox16),
                            Text(
                              "Hasil tidak ada",
                              style: TextStyle(
                                color: AppColors.grey600,
                                fontSize: AppSizes.fontSize18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: AppSizes.heightSizeBox8),
                            Text(
                              "Coba kata kunci lain",
                              style: TextStyle(
                                color: AppColors.grey600,
                                fontSize: AppSizes.fontSize14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.all(AppSizes.paddingAll10),
                      itemCount: controller.filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = controller.filteredDoctors[index];
                        final firstClinic = doctor["clinics"].isNotEmpty
                            ? doctor["clinics"][0]
                            : null;
                        return Obx(() {
                          if (controller.isAdmin) {
                            return Dismissible(
                              key: Key(doctor['id']),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: AppColors.redColor,
                                padding: EdgeInsets.only(
                                  right: AppSizes.paddingRigth20,
                                ),
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  color: AppColors.whiteColor,
                                  size: AppSizes.iconSize32,
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Hapus Dokter",
                                        style: TextStyle(
                                          color: AppColors.blueColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppSizes.fontSize18,
                                        ),
                                      ),
                                      content: Text(
                                        "Apakah Anda yakin ingin menghapus dokter ini?",
                                        style: TextStyle(
                                          color: AppColors.black87,
                                          fontSize: AppSizes.fontSize12,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text(
                                            "Batal",
                                            style: TextStyle(
                                              color: AppColors.blueColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSizes.fontSize14,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: Text(
                                            "Hapus",
                                            style: TextStyle(
                                              color: AppColors.redColor,
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
                              onDismissed: (direction) async {
                                await controller.deleteDoctor(doctor['id']);
                                controller.filteredDoctors.removeAt(index);
                              },
                              child: buildDoctorCard(doctor, firstClinic),
                            );
                          } else {
                            return buildDoctorCard(doctor, firstClinic);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: Obx(() {
        if (controller.isAdmin) {
          return FloatingActionButton.extended(
            heroTag: 'add_doctor',
            onPressed: () async {
              final result = await Get.toNamed(Routes.ADD_DOCTOR);
              if (result == true) {
                controller.fetchDoctors();
              }
            },
            backgroundColor: AppColors.blueColor,
            icon: Icon(
              Icons.add,
              color: AppColors.whiteColor,
              size: AppSizes.iconSize28,
            ),
            label: Text(
              'Tambah Dokter',
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.fontSize14),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      }),
    );
  }

  Widget buildDoctorCard(
      Map<String, dynamic> doctor, Map<String, dynamic>? firstClinic) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AppSizes.paddingBottom10,
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            Routes.DETAIL_DOCTOR,
            arguments: doctor,
          );
        },
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.borderRadius12,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.paddingAll16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Doctor Image
                    ClipOval(
                      child: Image.network(
                        doctor["image"],
                        width: AppSizes.imageWidth70,
                        height: AppSizes.imageHeight70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return ClipOval(
                            child: Container(
                              width: AppSizes.imageWidth70,
                              height: AppSizes.imageHeight70,
                              color: AppColors.blueColor,
                              child: Icon(
                                Icons.person,
                                color: AppColors.whiteColor,
                                size: AppSizes.iconSize40,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: AppSizes.widthSizeBox10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: AppColors.blueAccentColor,
                                size: AppSizes.iconSize20,
                              ),
                              SizedBox(width: AppSizes.widthSizeBox8),
                              Expanded(
                                child: AppStyles.bold(
                                  title: doctor["name"],
                                  size: AppSizes.fontSize18,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSizes.heightSizeBox8),
                          // Specialty
                          Row(
                            children: [
                              Icon(
                                Icons.local_hospital,
                                color: AppColors.grey700,
                                size: AppSizes.iconSize18,
                              ),
                              SizedBox(width: AppSizes.widthSizeBox8),
                              Expanded(
                                child: AppStyles.normal(
                                  title: doctor["specialty"],
                                  size: AppSizes.fontSize14,
                                  color: AppColors.grey700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSizes.heightSizeBox8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.redAccentColor,
                                size: AppSizes.iconSize18,
                              ),
                              SizedBox(width: AppSizes.widthSizeBox8),
                              Expanded(
                                child: AppStyles.normal(
                                  title: firstClinic?["clinicName"] ??
                                      "No Clinic Available",
                                  size: AppSizes.fontSize14,
                                  color: AppColors.grey700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: AppSizes.heightSizeBox8),
                Divider(
                  thickness: AppSizes.deviderThickness1,
                  color: AppColors.grey300,
                ),
                SizedBox(height: AppSizes.heightSizeBox8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppStyles.normal(
                          title: "Estimated Fee",
                          size: AppSizes.fontSize14,
                          color: AppColors.grey700,
                        ),
                        AppStyles.bold(
                          title: controller.formatFee(
                              doctor["currency"], doctor["fee"]),
                          size: AppSizes.fontSize16,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          Routes.DETAIL_DOCTOR,
                          arguments: doctor,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.borderRadius12),
                        ),
                        minimumSize: Size(
                            AppSizes.widthSizeBox180, AppSizes.heightSizeBox50),
                      ),
                      child: AppStyles.normal(
                        title: "Make Appointment",
                        size: AppSizes.fontSize14,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
