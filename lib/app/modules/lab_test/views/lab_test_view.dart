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
                  size: AppSizes.size18,
                )),
            Obx(() => AppStyles.normal(
                  title: controller.userAddress.value,
                  color: AppColors.whiteColor.withOpacity(0.8),
                  size: AppSizes.size12,
                )),
          ],
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
                      textController: controller.searchController,
                      onChanged: (value) {
                        // Panggil method search
                        controller.searchLabTests(value);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(() {
                    return IconButton(
                      icon: Icon(
                        controller.isListening.value
                            ? Icons.mic
                            : Icons.mic_none,
                        color: controller.isListening.value
                            ? Colors.red
                            : Colors.white,
                      ),
                      onPressed: () {
                        if (controller.isListening.value) {
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
                      height: 33,
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
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.blueColor
                                        : AppColors.blueColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: AppStyles.normal(
                                      title: test,
                                      size: AppSizes.size14,
                                      color: isSelected
                                          ? Colors.white
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
                            width: 250,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Hasil tidak ada",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Coba kata kunci lain",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
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
                                    title: Text('Hapus Lab Test'),
                                    content: Text(
                                        'Apakah Anda yakin ingin menghapus lab test ini?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: Text('Hapus'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 30,
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
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'Tambah Lab Test',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }

  Widget _buildLabTestCard(Map<String, dynamic> labTest) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.DETAIL_LAB_TEST, arguments: labTest);
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
                        errorBuilder: (context, error, stackTrace) {
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppStyles.normal(
                          title: "Estimated Fee",
                          size: AppSizes.size14,
                          color: Colors.grey[700]!,
                        ),
                        AppStyles.bold(
                          title: controller.formatFee(
                              labTest['currency'], labTest['price']),
                          size: AppSizes.size16,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.DETAIL_LAB_TEST, arguments: labTest);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
  }
}
