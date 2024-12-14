import 'package:aplikasi_booking_dokter/app/modules/bottom_navbar/bindings/navbar_bottom_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/bottom_navbar/views/navbar_bottom_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/lab_test/bindings/lab_test_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/lab_test/views/lab_test_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/login/bindings/login_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/login/views/login_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/forget_password/bindings/forget_password_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/forget_password/views/forget_password_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/profiles/bindings/profiles_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/profiles/views/profiles_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/signup/bindings/signup_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/signup/views/signup_view.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVBAR,
      page: () => NavbarBottomView(),
      binding: NavbarBottomBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILES,
      page: () => ProfilesView(),
      binding: ProfilesBinding(),
    ),
    GetPage(
      name: _Paths.LAB_TEST,
      page: () => LabTestView(),
      binding: LabTestBinding(),
    ),
  ];
}
