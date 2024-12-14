import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:aplikasi_booking_dokter/app/modules/home/views/home_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/lab_test/views/lab_test_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/profiles/views/profiles_view.dart';
import 'package:get/get.dart';

class NavbarBottomController extends GetxController {
  var selectedIndex = 0.obs; // Observable index for selected tab

  void changeTab(int index) {
    selectedIndex.value = index; // Update the selected tab
  }

  final List<Widget> pages = [
    HomeView(),
    LabTestView(),
    Center(child: Text("Webview")),
    Center(child: Text("History")),
    ProfilesView(),
  ];
}
