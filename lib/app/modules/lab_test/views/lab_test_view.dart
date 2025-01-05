import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/lotties.dart';
import 'package:aplikasi_booking_dokter/app/modules/lab_test/controllers/lab_test_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LabTestView extends GetView<LabTestController> {
  const LabTestView({super.key});

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
            ),
          );
        }

        if (controller.labTests.isEmpty) {
          return Center(
            child: Text("No lab tests available."),
          );
        }

        return Column(
          children: [
            // Search box tetap di atas
            Container(
              padding: EdgeInsets.all(AppSizes.paddingAll12),
              color: AppColors.blueColor,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      hint: AppStrings.searchHospital,
                      borderColor: AppColors.whiteColor,
                      textColor: AppColors.whiteColor,
                      textController: controller.searchController,
                      onChanged: (value) {
                        controller.searchLabTests(value);
                      },
                    ),
                  ),
                  SizedBox(width: AppSizes.widthSizeBox10),
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
                          controller.stopVoiceSearch();
                        } else {
                          controller.startVoiceSearch();
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
            // Horizontal ListView untuk "Berbagai jenis lab test"
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
                    title: "Available Lab Tests",
                    size: AppSizes.fontSize18,
                    color: AppColors.blueColor,
                  ),
                  SizedBox(
                      height: AppSizes.heightSizeBox33,
                      child: Obx(() {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.labTestTypes.length,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              final test = controller.labTestTypes[index];
                              final isSelected =
                                  controller.selectedLabTestType.value == test;
                              return GestureDetector(
                                onTap: () {
                                  controller.filterLabTestByTest(test);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: AppSizes.marginRight8),
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
                                      title: test,
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
                        );
                      })),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.fetchLabTests,
                child: Obx(() {
                  if (controller.filteredLabTests.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            AppLotties.search_not_found,
                            width: AppSizes.lottieWidth250,
                            height: AppSizes.lottieHeight250,
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
                    padding: EdgeInsets.only(
                      left: AppSizes.paddingLeft10,
                      right: AppSizes.paddingRight10,
                      top: AppSizes.paddingTop5,
                      bottom: AppSizes.paddingBottom5,
                    ),
                    itemCount: controller.filteredLabTests.length,
                    itemBuilder: (context, index) {
                      final labTest = controller.filteredLabTests[index];
                      return Obx(() {
                        if (controller.isAdmin) {
                          return Dismissible(
                            key: Key(labTest['id']),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              // Tampilkan dialog konfirmasi
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Hapus Lab Test',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blueColor,
                                        fontSize: AppSizes.fontSize18,
                                      ),
                                    ),
                                    content: Text(
                                      'Apakah Anda yakin ingin menghapus lab test ini?',
                                      style: TextStyle(
                                        color: AppColors.grey800,
                                        fontSize: AppSizes.fontSize12,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text(
                                          'Batal',
                                          style: TextStyle(
                                            color: AppColors.redColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSizes.fontSize14,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: Text(
                                          'Hapus',
                                          style: TextStyle(
                                            color: AppColors.blueColor,
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
                            background: Container(
                              color: AppColors.redColor,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.paddingHorizontal20,
                              ),
                              child: Icon(
                                Icons.delete,
                                color: AppColors.whiteColor,
                                size: AppSizes.iconSize30,
                              ),
                            ),
                            onDismissed: (direction) {
                              // Hapus lab test
                              controller.deleteLabTest(labTest['id']);
                            },
                            child: _buildLabTestCard(labTest),
                          );
                        } else {
                          return _buildLabTestCard(labTest);
                        }
                      });
                    },
                  );
                }),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: Obx(() {
        if (controller.isAdmin) {
          return FloatingActionButton.extended(
            heroTag: 'add_lab_test',
            onPressed: () async {
              final result = await Get.toNamed(Routes.ADD_LAB_TEST);
              if (result == true) {
                controller.fetchLabTests();
              }
            },
            backgroundColor: AppColors.blueColor,
            icon: Icon(
              Icons.add,
              color: AppColors.whiteColor,
              size: AppSizes.iconSize28,
            ),
            label: Text(
              'Tambah Lab Test',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.fontSize14,
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      }),
    );
  }

  Widget _buildLabTestCard(Map<String, dynamic> labTest) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AppSizes.paddingBottom5,
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.DETAIL_LAB_TEST, arguments: labTest);
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
                    // Gambar rumah sakit
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSizes.borderRadius12),
                      child: Image.network(
                        labTest["image"],
                        width: AppSizes.imageWidth70,
                        height: AppSizes.imageHeight70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: AppSizes.imageWidth70,
                            height: AppSizes.imageHeight70,
                            color: AppColors.blueColor,
                            child: Icon(
                              Icons.image_not_supported,
                              color: AppColors.whiteColor,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: AppSizes.widthSizeBox10),
                    // Informasi rumah sakit
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Rumah Sakit
                          Row(
                            children: [
                              Icon(
                                Icons.local_hospital,
                                size: AppSizes.iconSize20,
                                color: AppColors.greenColor,
                              ),
                              SizedBox(width: AppSizes.widthSizeBox6),
                              Expanded(
                                child: AppStyles.bold(
                                  title: labTest["hospital"],
                                  size: AppSizes.fontSize18,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSizes.heightSizeBox8),

                          // Jenis Tes
                          Row(
                            children: [
                              Icon(
                                Icons.science,
                                size: AppSizes.iconSize18,
                                color: AppColors.grey700,
                              ),
                              SizedBox(width: AppSizes.widthSizeBox6),
                              Expanded(
                                child: AppStyles.normal(
                                  title: labTest["test"],
                                  size: AppSizes.fontSize14,
                                  color: AppColors.grey700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSizes.heightSizeBox4),

                          // Lokasi
                          Row(
                            children: [
                              Icon(
                                Icons.map_outlined,
                                size: AppSizes.iconSize18,
                                color: AppColors.redAccentColor,
                              ),
                              SizedBox(width: AppSizes.widthSizeBox6),
                              Expanded(
                                child: AppStyles.normal(
                                  title:
                                      "${labTest['location']['district']}, ${labTest['location']['city']}",
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
                              labTest['currency'], labTest['price']),
                          size: AppSizes.fontSize16,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.DETAIL_LAB_TEST, arguments: labTest);
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
                        title: "Book Test",
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
