import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/routes/app_pages.dart';

import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: ThemeData(fontFamily: AppFonts.nunito),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
