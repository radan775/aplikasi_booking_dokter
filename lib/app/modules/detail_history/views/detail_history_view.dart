import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_history/controllers/detail_history_controller.dart';

class DetailHistoryView extends GetView<DetailHistoryController> {
  const DetailHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingAll12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorAndLocationCard(),
            SizedBox(height: AppSizes.heightSizeBox20),
            _buildPatientDataCard(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.blueColor,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: AppSizes.iconSize28,
        ),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Detail History',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.fontSize20,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildDoctorAndLocationCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadius16,
        ),
      ),
      child: Obx(() {
        if (controller.historyData['type'] == 'doctor') {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusContainer(),
              _buildDoctorDetails(),
              Divider(
                thickness: AppSizes.deviderThickness1,
                color: Colors.grey,
              ),
              _buildLocationDetails(),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusContainer(),
              _buildLocationDetails(),
            ],
          );
        }
      }),
    );
  }

  Widget _buildDoctorDetails() {
    return Padding(
      padding: EdgeInsets.all(AppSizes.paddingAll16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dokter pilihan anda",
            style: TextStyle(
              fontSize: AppSizes.fontSize16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSizes.heightSizeBox8),
          Row(
            children: [
              CircleAvatar(
                radius: AppSizes.avatarRadius40,
                backgroundImage:
                    NetworkImage(controller.historyData['doctorImage']),
                backgroundColor: Colors.grey[200],
              ),
              SizedBox(width: AppSizes.widthSizeBox16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.historyData['doctorName'],
                      style: TextStyle(
                        fontSize: AppSizes.fontSize18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.heightSizeBox4,
                    ),
                    Text(
                      controller.historyData['doctorSpecialty'],
                      style: TextStyle(
                        fontSize: AppSizes.fontSize16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDetails() {
    return Padding(
      padding: EdgeInsets.all(AppSizes.paddingAll16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
            child: Image.network(
              controller.historyData['clinicImage'],
              width: AppSizes.imageWidth80,
              height: AppSizes.imageHeight80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: AppSizes.heightSizeBox16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.historyData['clinicName'],
                  style: TextStyle(
                    fontSize: AppSizes.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.historyData['clinicAddress'],
                  style: TextStyle(
                    fontSize: AppSizes.fontSize14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${controller.historyData['selectedDay']}, ${controller.historyData['selectedDate']}',
                  style: TextStyle(
                    fontSize: AppSizes.fontSize14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  controller.historyData['selectedTime'],
                  style: TextStyle(
                    fontSize: AppSizes.fontSize14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusContainer() {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingAll8),
      color: Colors.green[100],
      alignment: Alignment.center,
      child: Text(
        'Dikonfirmasi',
        style: TextStyle(
          fontSize: AppSizes.fontSize16,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildPatientDataCard() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingAll16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data Pasien",
                style: TextStyle(
                  fontSize: AppSizes.fontSize16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildDetailRow(
                  "Nama lengkap", controller.historyData['patientName']),
              buildDetailRow(
                  "Tanggal lahir", controller.historyData['patientBirthdate']),
              buildDetailRow("Email", controller.historyData['patientEmail']),
              buildDetailRow(
                  "Nomor HP", controller.historyData['patientPhone']),
              buildDetailRow(
                  "Alamat", controller.historyData['patientAddress']),
              buildDetailRow(
                  "Jenis kelamin", controller.historyData['patientGender']),
              buildDetailRow(
                  "Metode pembayaran", controller.historyData['paymentMethod']),
              buildDetailRow(
                  "Sudah pernah ke RS?", controller.historyData['hasVisited']),
              buildDetailRow("Code pemesanan", controller.historyData['code']),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.paddingVertical4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: AppSizes.fontSize16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: AppSizes.heightSizeBox4),
          Text(
            value,
            style: TextStyle(
              fontSize: AppSizes.fontSize14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
