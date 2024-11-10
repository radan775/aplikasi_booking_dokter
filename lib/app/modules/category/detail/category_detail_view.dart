import 'package:flutter/material.dart';

import '../../../data/consts/consts.dart';

class CategoryDetailView extends StatelessWidget {
  const CategoryDetailView({super.key});

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
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 170,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8
              ),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.bgDarkColor,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(right: 8),
              height: 100,
              width: 150,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: AppColors.blueColor,
                    child: Image.asset(
                      AppAssets.imgSignup,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  5.heightBox,
                  AppStyles.normal(title: "Doctor Name"),
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
            );
          },
        ),
      ),
    );
  }
}
