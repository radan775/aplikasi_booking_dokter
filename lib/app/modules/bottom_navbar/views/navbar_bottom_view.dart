import 'package:aplikasi_booking_dokter/app/modules/bottom_navbar/controllers/navbar_bottom_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class NavbarBottomView extends GetView<NavbarBottomController> {
  const NavbarBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Tampilan berdasarkan tab yang dipilih
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: List.generate(
            controller.pages.length,
            (index) => Navigator(
              key: Get.nestedKey(index), // Kunci otomatis berdasarkan index
              onGenerateRoute: (settings) => GetPageRoute(
                page: () => controller.pages[index],
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 5,
              activeColor: Colors.black,
              iconSize: 20,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: FontAwesomeIcons.flask,
                  text: 'Lab Test',
                ),
                GButton(
                  icon: Icons.web,
                  text: 'WebView',
                ),
                GButton(
                  icon: Icons.history,
                  text: 'History',
                ),
                GButton(
                  icon: Icons.account_box_rounded,
                  text: 'Account',
                ),
              ],
              selectedIndex: controller.selectedIndex.value,
              onTabChange: (index) {
                controller.changeTab(index); // Ubah tab
              },
            ),
          ),
        ),
      ),
    );
  }
}
