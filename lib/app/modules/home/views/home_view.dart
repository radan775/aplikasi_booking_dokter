import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/res/components/custom_textfield.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: AppStyles.bold(
            title: "${AppStrings.welcome} User",
            color: AppColors.whiteColor,
            size: AppSizes.size18),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 100,
            color: AppColors.blueColor,
            child: CustomTextfield(
              hint: AppStrings.search,
              borderColor: AppColors.whiteColor,
              textColor: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
