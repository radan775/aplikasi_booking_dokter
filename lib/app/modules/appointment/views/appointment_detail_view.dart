import '../../../data/consts/consts.dart';
import '../../../res/components/custom_textfield.dart';

class AppointmentDetailView extends StatelessWidget {
  const AppointmentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: AppStyles.bold(
            title: "Doctor Name",
            color: AppColors.whiteColor,
            size: AppSizes.size18),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            AppStyles.bold(title: "Select Appointment Day"),
              5.heightBox,
              AppStyles.normal(title: "Selected Day"),
              10.heightBox,
              AppStyles.bold(title: "Select Appointment Time"),
              5.heightBox,
              AppStyles.normal(title: "Selected Time"),
              20.heightBox,
              AppStyles.bold(title: "Mobile Number:"),
              5.heightBox,
              AppStyles.normal(title: "Mobile Number"),
              10.heightBox,
              AppStyles.bold(title: "Full Name:"),
              5.heightBox,
              AppStyles.normal(title: "Name"),
              10.heightBox,
              AppStyles.bold(title: "Message:"),
              5.heightBox,
              AppStyles.normal(title: "Message"),
          ],
        ),
        ),
    );
  }
}
