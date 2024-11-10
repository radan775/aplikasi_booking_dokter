import 'package:aplikasi_booking_dokter/app/modules/appointment/views/appointment_detail_view.dart';
import 'package:get/get.dart';

import '../../../data/consts/consts.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: "Appointments",
          color: AppColors.whiteColor,
          size: AppSizes.size18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Get.to(() => const AppointmentDetailView());
                },
                leading: CircleAvatar(
                  child: Image.asset(AppAssets.imgSignup),
                ),
                title: AppStyles.bold(title: "Doctor Name"),
                subtitle: AppStyles.normal(
                    title: "Appointment time",
                    color: AppColors.textColor.withOpacity(0.5)),
              );
            }),
      ),
    );
  }
}
