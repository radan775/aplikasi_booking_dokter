import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


void main() {
  runApp(
    GetMaterialApp(
      theme: ThemeData(fontFamily: AppFonts.nunito),
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    ),
  );
}
