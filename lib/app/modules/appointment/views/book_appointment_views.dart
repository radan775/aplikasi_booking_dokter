import 'package:aplikasi_booking_dokter/app/res/components/custom_button.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';
import 'package:get/get.dart';

import '../../../data/consts/consts.dart';

class BookAppointmentViews extends StatelessWidget {
  const BookAppointmentViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: "Category Name",
          color: AppColors.whiteColor,
          size: AppSizes.size18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyles.bold(title: "Select Appointment Day"),
              5.heightBox,
              CustomTextfield(hint: "Select Date"),
              10.heightBox,
              AppStyles.bold(title: "Select Appointment Time"),
              5.heightBox,
              CustomTextfield(hint: "Select Time"),
              20.heightBox,
              AppStyles.bold(title: "Mobile Number"),
              5.heightBox,
              CustomTextfield(hint: "Enter Your Mobile Number"),
              10.heightBox,
              AppStyles.bold(title: "Full Name"),
              5.heightBox,
              CustomTextfield(hint: "Enter Your Name"),
              10.heightBox,
              AppStyles.bold(title: "Message"),
              5.heightBox,
              CustomTextfield(hint: "Enter Your Message"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(
          buttonText: "Book an Appointment",
          onTap: () {},
        ),
      ),
    );
  }
}
