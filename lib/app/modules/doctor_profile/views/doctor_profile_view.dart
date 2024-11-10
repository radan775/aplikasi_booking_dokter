import 'package:aplikasi_booking_dokter/app/modules/appointment/views/book_appointment_views.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_button.dart';
import 'package:get/get.dart';

import '../../../data/consts/consts.dart';

class DoctorProfileView extends StatelessWidget {
  const DoctorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: "Doctor Name",
          color: AppColors.whiteColor,
          size: AppSizes.size18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Image.asset(AppAssets.imgSignup),
                  ),
                  10.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppStyles.bold(
                          title: "Doctor Name",
                          color: AppColors.textColor,
                          size: AppSizes.size14,
                        ),
                        AppStyles.bold(
                          title: "Category",
                          color: AppColors.textColor.withOpacity(0.5),
                          size: AppSizes.size12,
                        ),
                        const Spacer(),
                        VxRating(
                          selectionColor: AppColors.yellowColor,
                          onRatingUpdate: (value) {},
                          maxRating: 5,
                          count: 5,
                          value: 4,
                          stepInt: true,
                        )
                      ],
                    ),
                  ),
                  AppStyles.bold(
                    title: "See All Reviews",
                    color: AppColors.blueColor,
                    size: AppSizes.size14,
                  ),
                ],
              ),
            ),
            10.heightBox,
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.whiteColor,
              ),
              child: Column(
                children: [
                  ListTile(
                    title: AppStyles.bold(
                      title: "Phone Number",
                      color: AppColors.textColor,
                    ),
                    subtitle: AppStyles.normal(
                      title: "+628645773829",
                      color: AppColors.textColor.withOpacity(0.5),
                      size: AppSizes.size12,
                    ),
                    trailing: Container(
                        width: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.yellowColor,
                        ),
                        child: Icon(
                          Icons.phone,
                          color: AppColors.whiteColor,
                        )),
                  ),
                  10.heightBox,
                  AppStyles.bold(
                    title: "About",
                    color: AppColors.textColor,
                    size: AppSizes.size14,
                  ),
                  5.heightBox,
                  AppStyles.normal(
                    title: "This is the about section of a doctor",
                    color: AppColors.textColor.withOpacity(0.5),
                    size: AppSizes.size12,
                  ),
                  10.heightBox,
                  AppStyles.bold(
                    title: "Address",
                    color: AppColors.textColor,
                    size: AppSizes.size14,
                  ),
                  5.heightBox,
                  AppStyles.normal(
                    title: "Address of the doctor",
                    color: AppColors.textColor.withOpacity(0.5),
                    size: AppSizes.size12,
                  ),
                  10.heightBox,
                  AppStyles.bold(
                    title: "Working Time",
                    color: AppColors.textColor,
                    size: AppSizes.size14,
                  ),
                  5.heightBox,
                  AppStyles.normal(
                    title: "This is the service section of a doctor",
                    color: AppColors.textColor.withOpacity(0.5),
                    size: AppSizes.size12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(
            buttonText: "Book an appointment",
            onTap: () {
              Get.to(() => const BookAppointmentViews());
            }),
      ),
    );
  }
}
