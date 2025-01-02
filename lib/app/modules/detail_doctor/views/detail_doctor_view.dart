import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Profil Dokter',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
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
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        doctorData['image'] ?? '',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorData['name'] ?? 'Unknown',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            doctorData['specialty'] ?? 'Unknown',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
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
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          expandedIndex.value = isExpanded ? -1 : index;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  clinic['clinicImage'] ?? '',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey,
                                      child:
                                          const Icon(Icons.image_not_supported),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      clinic['clinicName'] ?? 'Unknown Clinic',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      clinic['address'] ??
                                          'No address available',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Biaya: Rp$doctorFee',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
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
                          padding: const EdgeInsets.all(16.0),
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
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      nextDate,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
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
                                            ? Colors.green
                                            : Colors.blueAccent,
                                      ),
                                      title: Text('$startTime - $endTime'),
                                      onTap: () {
                                        controller.selectSchedule(
                                          doctorId,
                                          clinicId,
                                          dayName,
                                          startTime,
                                          endTime,
                                        );
                                      },
                                      trailing: isSelected
                                          ? const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
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
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.DETAIL_PEMESAN);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: AppColors.blueColor,
          ),
          child: const Text(
            'Buat Janji Pertemuan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfilCard(String title, String content) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListExpandableCard(String title, List<dynamic> items) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconColor: AppColors.blueColor,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map<Widget>(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
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
