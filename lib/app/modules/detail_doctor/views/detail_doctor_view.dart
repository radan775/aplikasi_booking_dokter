import 'package:get/get.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_doctor/controllers/detail_doctor_controller.dart';

class DetailDoctorView extends GetView<DetailDoctorController> {
  const DetailDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorData = controller.doctorData;
    final RxInt expandedIndex = (-1).obs;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
            size: AppSizes.iconSize28,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Profil Dokter',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.fontSize20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingAll12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Profile Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.borderRadius16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: AppSizes.avatarRadius40,
                      backgroundImage: NetworkImage(
                        doctorData['image'] ?? '',
                      ),
                    ),
                    SizedBox(width: AppSizes.heightSizeBox16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorData['name'] ?? 'Unknown',
                            style: TextStyle(
                              fontSize: AppSizes.fontSize12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: AppSizes.heightSizeBox8),
                          Text(
                            doctorData['specialty'] ?? 'Unknown',
                            style: TextStyle(
                              fontSize: AppSizes.fontSize16,
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ...List.generate((doctorData['clinics'] as List).length, (index) {
              final clinic = (doctorData['clinics'] as List)[index];
              return Obx(() {
                final isExpanded = expandedIndex.value == index;
                final clinicId = clinic['clinicId'];
                final doctorId = doctorData['id'];
                final doctorFee = doctorData['fee'] ?? '0';

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizes.marginVertical8,
                    ),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          expandedIndex.value = isExpanded ? -1 : index;
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadius12,
                                ),
                                child: Image.network(
                                  clinic['clinicImage'] ?? '',
                                  width: AppSizes.imageWidth80,
                                  height: AppSizes.imageHeight80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: AppSizes.imageWidth80,
                                      height: AppSizes.imageHeight80,
                                      color: AppColors.greyColor,
                                      child: Icon(Icons.image_not_supported),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: AppSizes.widthSizeBox16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      clinic['clinicName'] ?? 'Unknown Clinic',
                                      style: TextStyle(
                                        fontSize: AppSizes.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    SizedBox(height: AppSizes.heightSizeBox8),
                                    Text(
                                      clinic['address'] ??
                                          'No address available',
                                      style: TextStyle(
                                        fontSize: AppSizes.fontSize14,
                                        color: AppColors.greyColor,
                                      ),
                                    ),
                                    SizedBox(height: AppSizes.heightSizeBox8),
                                    Text(
                                      'Biaya: Rp$doctorFee',
                                      style: TextStyle(
                                        fontSize: AppSizes.fontSize16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isExpanded)
                        Padding(
                          padding: EdgeInsets.all(AppSizes.paddingAll16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                (clinic['schedule'] as Map<String, dynamic>? ??
                                        {})
                                    .entries
                                    .map<Widget>((entry) {
                              final dayName = entry.key;
                              final times = entry.value as List<dynamic>? ?? [];
                              final nextDate =
                                  controller.getNextDateForDay(dayName);

                              return ExpansionTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      dayName.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: AppSizes.fontSize16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      nextDate,
                                      style: TextStyle(
                                        fontSize: AppSizes.fontSize14,
                                        color: AppColors.greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                                iconColor: AppColors.blueColor,
                                children: times.map<Widget>((time) {
                                  final startTime =
                                      time['startTime'] ?? 'Unknown';
                                  final endTime = time['endTime'] ?? 'Unknown';

                                  return Obx(() {
                                    final isSelected = controller
                                                    .selectedSchedule[clinicId]
                                                ?['day'] ==
                                            dayName &&
                                        controller.selectedSchedule[clinicId]
                                                ?['startTime'] ==
                                            startTime;

                                    return ListTile(
                                      leading: Icon(
                                        Icons.access_time,
                                        color: isSelected
                                            ? AppColors.greenColor
                                            : AppColors.blueAccentColor,
                                        size: AppSizes.iconSize25,
                                      ),
                                      title: Text(
                                        '$startTime - $endTime',
                                        style: TextStyle(
                                          fontSize: AppSizes.fontSize12,
                                        ),
                                      ),
                                      onTap: () {
                                        controller.selectSchedule(
                                          doctorId,
                                          clinicId,
                                          dayName,
                                          startTime,
                                          endTime,
                                          nextDate,
                                          doctorFee,
                                        );
                                      },
                                      trailing: isSelected
                                          ? Icon(
                                              Icons.check_circle,
                                              color: AppColors.greenColor,
                                            )
                                          : null,
                                    );
                                  });
                                }).toList(),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                );
              });
            }),

            // Expandable Cards
            buildProfilCard(
              'Profil Dokter',
              doctorData['profile'] ?? 'No profile available',
            ),
            buildListExpandableCard(
              'Tindakan Medis',
              doctorData['treatments'] as List? ?? [],
            ),
            buildListExpandableCard(
              'Pengalaman Praktik',
              doctorData['experiences'] as List? ?? [],
            ),
            buildListExpandableCard(
              'Riwayat Pendidikan',
              doctorData['education'] as List? ?? [],
            ),
          ],
        ),
      ),

      // Bottom Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.paddingAll12),
        child: ElevatedButton(
          onPressed: () {
            // Cek apakah schedule sudah dipilih
            controller.handleBuatJanji();
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.paddingVertical16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSizes.borderRadius16,
              ),
            ),
            backgroundColor: AppColors.blueColor,
          ),
          child: Text(
            'Buat Janji Pertemuan',
            style: TextStyle(
              fontSize: AppSizes.fontSize18,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfilCard(String title, String content) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius10),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingAll16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: AppSizes.fontSize16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSizes.heightSizeBox8),
              Text(
                content,
                style: TextStyle(
                  fontSize: AppSizes.fontSize14,
                  color: AppColors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListExpandableCard(String title, List<dynamic> items) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadius10,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: AppSizes.fontSize16,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconColor: AppColors.blueColor,
        children: [
          Padding(
            padding: EdgeInsets.all(AppSizes.paddingAll16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map<Widget>(
                    (item) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSizes.paddingVertical4,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.greenColor,
                            size: AppSizes.iconSize20,
                          ),
                          SizedBox(width: AppSizes.widthSizeBox8),
                          Expanded(
                            child: Text(
                              item.toString(),
                              style: TextStyle(
                                fontSize: AppSizes.fontSize14,
                                color: AppColors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
