import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_pasien/controllers/detail_pasien_controller.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
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
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Detail Pasien",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingAll16),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.paddingAll16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lengkapi data pasien",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSizes.heightSizeBox8),
                Text(
                  "Silahkan lengkapi data pasien untuk buat janji:",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: AppSizes.heightSizeBox16),
                CustomTextfield(
                  hint: "Nama sesuai KTP/SKTT",
                  textController: controller.namaController,
                ),
                SizedBox(height: AppSizes.heightSizeBox16),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextfield(
                        hint: "Tanggal/Bulan/Tahun",
                        textController: controller.tanggalController,
                        inputType: TextInputType.number,
                        enabled: false,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
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
                SizedBox(height: AppSizes.heightSizeBox16),
                Text(
                  "Jenis kelamin pasien",
                  style: TextStyle(
                    fontSize: AppSizes.fontSize14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSizes.heightSizeBox8),
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
                    SizedBox(width: AppSizes.widthSizeBox2),
                    Expanded(
                      child: Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                controller.selectedGender.value == "Perempuan"
                                    ? AppColors.blueColor
                                    : Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
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
                SizedBox(height: AppSizes.heightSizeBox16),
                CustomTextfield(
                  hint: "No KTP/NIK Pasien",
                  textController: controller.nikController,
                ),
                SizedBox(height: AppSizes.heightSizeBox16),
                CustomTextfield(
                  hint: "Alamat sesuai KTP/SKTT pasien",
                  textController: controller.alamatController,
                  inputType: TextInputType.multiline,
                ),
                SizedBox(height: AppSizes.heightSizeBox24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: AppSizes.paddingVertical16),
                    backgroundColor: AppColors.blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.borderRadius8),
                    ),
                  ),
                  onPressed: () {
                    controller.simpanDataPasien();
                  },
                  child: Center(
                    child: Text(
                      "Lengkapi data pasien",
                      style: TextStyle(
                        fontSize: AppSizes.fontSize16,
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
