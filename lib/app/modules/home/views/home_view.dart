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
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: Obx(() => AppStyles.bold(
              title: "${AppStrings.welcome} ${controller.namalengkap.value}",
              color: AppColors.whiteColor,
              size: AppSizes.size18,
            )),
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
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.doctors.isEmpty) {
          return const Center(
            child: Text("No doctors available."),
          );
        }

        return Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.all(12),
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
                  const SizedBox(width: 10),
                  // Tambahkan tombol mikropon
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles.bold(
                    title: "Doctors",
                    size: AppSizes.size18,
                    color: AppColors.blueColor,
                  ),
                  SizedBox(
                    height: 33, // Tinggi dari horizontal ListView
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
                              print(
                                  "${controller.doctorTypes[index]} selected!");
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
                                  title: specialty,
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
                              width: 200,
                              height: 200,
                              repeat: true,
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
                      padding: const EdgeInsets.all(10.0),
                      itemCount: controller.filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = controller.filteredDoctors[index];
                        final firstClinic = doctor["clinics"].isNotEmpty
                            ? doctor["clinics"][0]
                            : null; // Klinik pertama

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.DETAIL_DOCTOR,
                                arguments: doctor,
                              );
                              print("Doctor ${doctor['name']} selected!");
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
                                        // Doctor Image
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
                                                  child: const Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                    size: 40,
                                                  ),
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
                                              // Doctor Name
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.person,
                                                    color: Colors.blueAccent,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: AppStyles.bold(
                                                      title: doctor["name"],
                                                      size: AppSizes.size18,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              // Specialty
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.local_hospital,
                                                    color: Colors.grey[700],
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: AppStyles.normal(
                                                      title:
                                                          doctor["specialty"],
                                                      size: AppSizes.size14,
                                                      color: Colors.grey[700]!,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    color: Colors.redAccent,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: AppStyles.normal(
                                                      title: firstClinic?[
                                                              "clinicName"] ??
                                                          "No Clinic Available",
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
                                                  doctor["currency"],
                                                  doctor["fee"]),
                                              size: AppSizes.size16,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.toNamed(
                                              Routes.DETAIL_DOCTOR,
                                              arguments: doctor,
                                            );
                                            print("Make Appointment clicked!");
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: AppStyles.normal(
                                            title: "Make Appointment",
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
