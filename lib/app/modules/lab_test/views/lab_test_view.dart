import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/lab_test/controllers/lab_test_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
import 'package:get/get.dart';

class LabTestView extends GetView<LabTestController> {
  const LabTestView({super.key});

  @override
  Widget build(BuildContext context) {
    // Jenis lab test

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: AppStyles.bold(
          title: "${AppStrings.welcome} User",
          color: AppColors.whiteColor,
          size: AppSizes.size18,
        ),
      ),
      body: Column(
        children: [
          // Search box tetap di atas
          Container(
            padding: const EdgeInsets.all(14),
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
            padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                SizedBox(
                  height: 32, // Tinggi dari horizontal ListView
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
                            color: const Color.fromARGB(255, 93, 174, 211),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: AppStyles.normal(
                              title: controller.labTestTypes[index],
                              size: AppSizes.size14,
                              color: Colors.white,
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
          // Tulisan "Lab Tests"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            alignment: Alignment.centerLeft,
            child: AppStyles.bold(
              title: "Lab Tests",
              size: AppSizes.size20,
              color: AppColors.blueColor,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: controller.labTests.length,
              itemBuilder: (context, index) {
                final labTest = controller.labTests[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: InkWell(
                    onTap: () {
                      print("Card ${labTest['hospital']} ditekan!");
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
                                  borderRadius: BorderRadius.circular(8),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppStyles.normal(
                                        title: labTest["hospital"],
                                        size: AppSizes.size18,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.science,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 5),
                                          AppStyles.normal(
                                            title: labTest["test"],
                                            size: AppSizes.size14,
                                            color: Colors.grey[700]!,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 5),
                                          AppStyles.normal(
                                            title:
                                                "${labTest['location']['district']}, ${labTest['location']['city']}",
                                            size: AppSizes.size14,
                                            color: Colors.grey[700]!,
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
                                      title: "Perkiraan biaya",
                                      size: AppSizes.size14,
                                      color: Colors.grey[700]!,
                                    ),
                                    AppStyles.normal(
                                      title: labTest["price"],
                                      size: AppSizes.size16,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    print("BUAT JANJI DITEKAN");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: AppStyles.normal(
                                    title: "Buat Janji",
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
        ],
      ),
    );
  }
}
