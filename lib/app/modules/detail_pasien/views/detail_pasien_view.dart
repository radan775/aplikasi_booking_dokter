import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_pasien/controllers/detail_pasien_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DetailPasienView extends GetView<DetailPasienController> {
  const DetailPasienView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Detail Pasien",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Lengkapi data pasien",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Silahkan lengkapi data pasien untuk buat janji:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  hint: "Nama sesuai KTP/SKTT",
                  textController: controller.namaController,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextfield(
                        hint: "Tanggal/Bulan/Tahun",
                        textController: controller.tanggalController,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (selectedDate != null) {
                          controller.tanggalController.text =
                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Jenis kelamin pasien",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                controller.selectedGender.value == "Laki-laki"
                                    ? AppColors.blueColor
                                    : Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(0), // Sudut kotak
                            ),
                          ),
                          onPressed: () {
                            controller.selectedGender.value = "Laki-laki";
                          },
                          child: Text(
                            "Laki-laki",
                            style: TextStyle(
                              color:
                                  controller.selectedGender.value == "Laki-laki"
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                controller.selectedGender.value == "Perempuan"
                                    ? AppColors.blueColor
                                    : Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(0), // Sudut kotak
                            ),
                          ),
                          onPressed: () {
                            controller.selectedGender.value = "Perempuan";
                          },
                          child: Text(
                            "Perempuan",
                            style: TextStyle(
                              color:
                                  controller.selectedGender.value == "Perempuan"
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  hint: "No KTP/NIK Pasien",
                  textController: controller.nikController,
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  hint: "Alamat sesuai KTP/SKTT pasien",
                  textController: controller.alamatController,
                  inputType: TextInputType.multiline,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppColors.blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.DETAIL_DATA_PASIEN);
                  },
                  child: const Center(
                    child: Text(
                      "Lengkapi data pasien",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
