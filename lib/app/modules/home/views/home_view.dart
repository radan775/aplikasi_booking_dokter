import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/home/controllers/home_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

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
                    hint: AppStrings.searchDoctor,
                    borderColor: AppColors.whiteColor,
                    textColor: AppColors.whiteColor,
                  ),
                ),
                10.widthBox,
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
                    itemCount: controller.doctorTypes.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print("${controller.doctorTypes[index]} dipilih!");
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
                              title: controller.doctorTypes[index],
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            alignment: Alignment.centerLeft, // Pastikan teks dimulai dari kiri
            child: AppStyles.bold(
              title: "List of doctors",
              size: AppSizes.size20,
              color: AppColors.blueColor,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                ...controller.doctors.map((doctor) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: InkWell(
                      onTap: () {
                        print("Card ${doctor['name']} ditekan!");
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
                                  ClipOval(
                                    child: Image.network(
                                      doctor["image"],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return ClipOval(
                                          child: Container(
                                            width: 70,
                                            height: 70,
                                            color: Colors.blue,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppStyles.normal(
                                          title: doctor["name"],
                                          size: AppSizes.size18,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.stethoscope,
                                              size: AppSizes.size14,
                                              color: Colors.grey[700]!,
                                            ),
                                            const SizedBox(width: 5),
                                            AppStyles.normal(
                                              title: doctor["specialty"],
                                              size: AppSizes.size14,
                                              color: Colors.grey[700]!,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.hospital,
                                              size: AppSizes.size14,
                                              color: Colors.grey[700]!,
                                            ),
                                            const SizedBox(width: 5),
                                            AppStyles.normal(
                                              title: doctor["clinic"],
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
                              const SizedBox(height: 2),
                              Divider(
                                thickness: 1,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppStyles.normal(
                                        title: "Perkiraan biaya",
                                        size: AppSizes.size14,
                                        color: Colors.grey[700]!,
                                      ),
                                      AppStyles.normal(
                                        title: doctor["fee"],
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
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
