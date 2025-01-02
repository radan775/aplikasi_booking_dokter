import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/lab_test/controllers/lab_test_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LabTestView extends GetView<LabTestController> {
  const LabTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: AppStyles.bold(
          title: "${AppStrings.welcome} User",
          color: AppColors.whiteColor,
          size: AppSizes.size18,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: AppColors.whiteColor),
            onPressed: () {
              Get.toNamed(Routes.NOTIFICATION);
            },
          ),
        ],
      ),
      body: Obx(() {
        // Cek apakah sedang loading
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Cek apakah data kosong
        if (controller.labTests.isEmpty) {
          return const Center(
            child: Text("No lab tests available."),
          );
        }

        return Column(
          children: [
            // Search box tetap di atas
            Container(
              padding: const EdgeInsets.all(12),
              color: AppColors.blueColor,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      hint: AppStrings.searchHospital,
                      borderColor: AppColors.whiteColor,
                      textColor: AppColors.whiteColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal ListView untuk "Berbagai jenis lab test"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles.bold(
                    title: "Available Lab Tests",
                    size: AppSizes.size18,
                    color: AppColors.blueColor,
                  ),
                  SizedBox(
                    height: 33, // Tinggi dari horizontal ListView
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.labTestTypes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print("${controller.labTestTypes[index]} dipilih!");
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.blueColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: AppStyles.normal(
                                title: controller.labTestTypes[index],
                                size: AppSizes.size14,
                                color: AppColors.blueColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.fetchLabTests,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  itemCount: controller.labTests.length,
                  itemBuilder: (context, index) {
                    final labTest = controller.labTests[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.DETAIL_LAB_TEST,
                              arguments: labTest);
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Gambar rumah sakit
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        labTest["image"],
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: 70,
                                            height: 70,
                                            color: Colors.blue,
                                            child: const Icon(
                                              Icons.image_not_supported,
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Informasi rumah sakit
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Nama Rumah Sakit
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.local_hospital,
                                                size: 20,
                                                color: Colors.green,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: AppStyles.bold(
                                                  title: labTest["hospital"],
                                                  size: AppSizes.size18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),

                                          // Jenis Tes
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.science,
                                                size: 18,
                                                color: Colors.grey[700],
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: AppStyles.normal(
                                                  title: labTest["test"],
                                                  size: AppSizes.size14,
                                                  color: Colors.grey[700]!,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),

                                          // Lokasi
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.map_outlined,
                                                size: 18,
                                                color: Colors.redAccent,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: AppStyles.normal(
                                                  title:
                                                      "${labTest['location']['district']}, ${labTest['location']['city']}",
                                                  size: AppSizes.size14,
                                                  color: Colors.grey[700]!,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppStyles.normal(
                                          title: "Estimated Fee",
                                          size: AppSizes.size14,
                                          color: Colors.grey[700]!,
                                        ),
                                        AppStyles.bold(
                                          title: controller.formatFee(
                                              labTest['currency'],
                                              labTest['price']),
                                          size: AppSizes.size16,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.DETAIL_LAB_TEST,
                                            arguments: labTest);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: AppStyles.normal(
                                        title: "Book Test",
                                        size: AppSizes.size14,
                                        color: Colors.white,
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
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
