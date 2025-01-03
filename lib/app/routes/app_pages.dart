import 'package:aplikasi_booking_dokter/app/modules/about/bindings/about_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/about/views/about_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/add_doctor/bindings/add_doctor_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/add_doctor/views/add_clinic_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/add_doctor/views/add_doctor_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/add_lab_test/bindings/add_lab_test_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/add_lab_test/views/add_lab_test_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/add_news/bindings/add_news_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/add_news/views/add_news_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/berita/bindings/berita_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/berita/views/berita_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/booking_berhasil/bindings/booking_berhasil_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/booking_berhasil/views/booking_berhasil_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/bottom_navbar/bindings/navbar_bottom_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/bottom_navbar/views/navbar_bottom_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/change_password/bindings/change_password_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/change_password/views/change_password_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/change_profile/bindings/change_profile_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/change_profile/views/change_profile_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_data_pasien/bindings/detail_data_pasien_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_data_pasien/views/detail_data_pasien_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_doctor/bindings/detail_doctor_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_doctor/views/detail_doctor_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_history/bindings/detail_history_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_history/views/detail_history_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_lab_test/bindings/detail_lab_test_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_lab_test/views/detail_lab_test_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_pasien/bindings/detail_pasien_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_pasien/views/detail_pasien_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_pemesan/bindings/detail_pemesan_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/detail_pemesan/views/detail_pemesan_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/help/bindings/help_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/help/views/help_detail_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/help/views/help_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/history/bindings/history_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/history/views/history_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/ini_webview/bindings/ini_webview_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/ini_webview/views/ini_webview_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/lab_test/bindings/lab_test_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/lab_test/views/lab_test_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/login/bindings/login_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/login/views/login_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/forget_password/bindings/forget_password_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/forget_password/views/forget_password_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/notification/bindings/notification_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/notification/views/notification_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/profiles/bindings/profiles_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/profiles/views/profiles_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/signup/bindings/signup_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/signup/views/signup_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/term_condition/bindings/term_condition_binding.dart';
import 'package:aplikasi_booking_dokter/app/modules/term_condition/views/term_condition_view.dart';
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
    GetPage(
      name: _Paths.BERITA,
      page: () => BeritaView(),
      binding: BeritaBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.INI_WEBVIEW,
      page: () => IniWebviewView(),
      binding: IniWebViewBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_DOCTOR,
      page: () => DetailDoctorView(),
      binding: DetailDoctorBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_LAB_TEST,
      page: () => DetailLabTestView(),
      binding: DetailLabTestBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PEMESAN,
      page: () => DetailPemesanView(),
      binding: DetailPemesanBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PASIEN,
      page: () => DetailPasienView(),
      binding: DetailPasienBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_DATA_PASIEN,
      page: () => DetailDataPasienView(),
      binding: DetailDataPasienBinding(),
    ),
    GetPage(
      name: _Paths.TERM_CONDITION,
      page: () => TermConditionView(),
      binding: TermConditionBinding(),
    ),
    GetPage(
      name: _Paths.HELP,
      page: () => HelpView(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: _Paths.HELP_DETAIL,
      page: () => HelpDetailView(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_HISTORY,
      page: () => DetailHistoryView(),
      binding: DetailHistoryBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PROFILE,
      page: () => ChangeProfileView(),
      binding: ChangeProfileBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_BERHASIL,
      page: () => BookingBerhasilView(),
      binding: BookingBerhasilBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NEWS,
      page: () => AddNewsView(),
      binding: AddNewsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_LAB_TEST,
      page: () => AddLabTestView(),
      binding: AddLabTestBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DOCTOR,
      page: () => AddDoctorView(),
      binding: AddDoctorBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DOCTOR_CLINIC,
      page: () => AddClinicView(),
    ),
  ];
}
