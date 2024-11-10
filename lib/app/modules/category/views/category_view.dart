import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/lists.dart';
import 'package:aplikasi_booking_dokter/app/modules/category/detail/category_detail_view.dart';
import 'package:get/get.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: AppStyles.bold(
            title: AppStrings.category,
            size: AppSizes.size18,
            color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            mainAxisExtent: 170,
          ),
          itemCount: iconsList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => const CategoryDetailView());
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.blueColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        iconsList[index],
                        width: 60,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    20.heightBox,
                    AppStyles.bold(
                      title: iconsTitleList[index],
                      color: AppColors.whiteColor,
                      size: AppSizes.size16,
                    ),
                    10.heightBox,
                    AppStyles.normal(
                      title: "13 specialists",
                      color: AppColors.whiteColor.withOpacity(0.5),
                      size: AppSizes.size16,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
