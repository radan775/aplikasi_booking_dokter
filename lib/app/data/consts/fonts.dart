import 'consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFonts {
  static String nunito = "nunito", nunitoBold = "nunito_bold";
}

class AppSizes {
  // Font Sizes
  static double get fontSize12 => 12.sp;
  static double get fontSize14 => 14.sp;
  static double get fontSize16 => 16.sp;
  static double get fontSize18 => 18.sp;
  static double get fontSize20 => 20.sp;
  static double get fontSize22 => 22.sp;
  static double get fontSize24 => 24.sp;
  static double get fontSize34 => 34.sp;

  // Padding and Margin
  static double get paddingAll4 => 4.r;
  static double get paddingAll8 => 8.r;
  static double get paddingAll10 => 10.r;
  static double get paddingAll12 => 12.r;
  static double get paddingAll16 => 16.r;

  static double get paddingVertical4 => 4.h;
  static double get paddingVertical8 => 8.h;
  static double get paddingVertical10 => 10.h;
  static double get paddingVertical12 => 12.h;
  static double get paddingVertical15 => 15.h;
  static double get paddingVertical16 => 16.h;

  static double get paddingHorizontal10 => 10.w;
  static double get paddingHorizontal12 => 12.w;
  static double get paddingHorizontal15 => 15.w;
  static double get paddingHorizontal16 => 16.w;
  static double get paddingHorizontal20 => 20.w;
  static double get paddingHorizontal40 => 40.w;
  static double get paddingHorizontal50 => 50.w;

  static double get paddingBottom8 => 8.h;
  static double get paddingBottom10 => 10.h;

  static double get paddingLeft10 => 10.w;
  static double get paddingRight10 => 10.w;
  static double get paddingRigth20 => 20.w;

  static double get paddingTop5 => 5.h;
  static double get paddingBottom5 => 5.h;

  // Heights and Widths
  static double get heightSizeBox3 => 3.h;
  static double get heightSizeBox4 => 4.h;
  static double get heightSizeBox5 => 5.h;
  static double get heightSizeBox6 => 6.h;
  static double get heightSizeBox8 => 8.h;
  static double get heightSizeBox10 => 10.h;
  static double get heightSizeBox12 => 12.h;
  static double get heightSizeBox16 => 16.h;
  static double get heightSizeBox20 => 20.h;
  static double get heightSizeBox24 => 24.h;
  static double get heightSizeBox30 => 30.h;
  static double get heightSizeBox33 => 33.h;
  static double get heightSizeBox40 => 40.h;
  static double get heightSizeBox44 => 44.h;
  static double get heightSizeBox50 => 50.h;
  static double get heightSizeBox60 => 60.h;

  static double get widthSizeBox2 => 2.w;
  static double get widthSizeBox4 => 4.w;
  static double get widthSizeBox6 => 6.w;
  static double get widthSizeBox8 => 8.w;
  static double get widthSizeBox10 => 10.w;
  static double get widthSizeBox16 => 16.w;
  static double get widthSizeBox180 => 180.w;
  static double get widthSizeBox332 => 332.w;

  // Border Radius
  static double get borderRadius8 => 8.r;
  static double get borderRadius10 => 10.r;
  static double get borderRadius12 => 12.r;
  static double get borderRadius16 => 16.r;
  static double get borderRadius20 => 20.r;

  // Avatar Radius
  static double get avatarRadius30 => 30.r;
  static double get avatarRadius40 => 40.r;
  static double get avatarRadius50 => 50.r;

  // Container Sizes
  static double get heightContainer200 => 200.h;
  static double get widthContainer330 => 330.w;

  // Icon Sizes
  static double get iconSize16 => 16.r;
  static double get iconSize18 => 18.r;
  static double get iconSize20 => 20.r;
  static double get iconSize25 => 25.r;
  static double get iconSize28 => 28.r;
  static double get iconSize30 => 30.r;
  static double get iconSize32 => 32.r;
  static double get iconSize40 => 40.r;
  static double get iconSize50 => 50.r;

  // Margins
  static double get marginRight8 => 8.w;
  static double get marginTop100 => 100.h;
  static double get marginTop120 => 120.h;
  static double get marginBottom10 => 10.h;
  static double get marginVertical4 => 4.h;
  static double get marginVertical8 => 8.h;
  static double get marginHorizontal16 => 16.w;

  // Images
  static double get imageWidth70 => 70.w;
  static double get imageWidth80 => 80.w;
  static double get imageWidth200 => 200.w;

  static double get imageHeight70 => 70.h;
  static double get imageHeight80 => 80.h;

  // Lottie Sizes
  static double get lottieWidth200 => 200.w;
  static double get lottieWidth250 => 250.w;

  static double get lottieHeight200 => 200.h;
  static double get lottieHeight250 => 250.h;

  // Others
  static double get deviderThickness1 => 1.r;
  static double get textHeight1_5 => 1.5.h;
  static double get heightSizeButton45 => 45.h;
  static double get widthBorderSide1_5 => 1.5.w;
  static double get widthBoxDecoration1_5 => 1.5.w;

  static double get loadingSize => 40.w;
  static double get strokeWidth3 => 3.w;

  static double get heightToolBar70 => 70.h;

  // Box Shadow
  static double get boxShadowSpreadRadius2 => 2.r;
  static double get boxShadowBlurRadius5 => 5.r;
  static double get boxShadowOffsetY3 => 3.h;
}

class AppStyles {
  static normal(
      {String? title,
      Color? color = Colors.black,
      double? size,
      TextAlign aligment = TextAlign.left}) {
    return title!.text.size(size).color(color).make();
  }

  static bold(
      {String? title,
      Color? color = Colors.black,
      double? size,
      TextAlign aligment = TextAlign.left}) {
    return title!.text
        .size(size)
        .color(color)
        .fontFamily(AppFonts.nunitoBold)
        .align(aligment)
        .make();
  }
}
