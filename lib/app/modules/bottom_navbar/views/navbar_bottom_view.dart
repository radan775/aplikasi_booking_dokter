import 'package:aplikasi_booking_dokter/app/data/consts/fonts.dart';
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
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: List.generate(
            controller.pages.length,
            (index) => Navigator(
              key: Get.nestedKey(index),
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
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingHorizontal15,
              vertical: AppSizes.paddingVertical8,
            ),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 5,
              activeColor: Colors.black,
              iconSize: AppSizes.iconSize20,
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal16,
                vertical: AppSizes.paddingVertical10,
              ),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  textStyle: TextStyle(
                    fontSize: AppSizes.fontSize16,
                    fontFamily: AppFonts.nunito,
                    fontWeight: FontWeight.bold,
                  ),
                  iconSize: AppSizes.iconSize25,
                ),
                GButton(
                    icon: FontAwesomeIcons.flask,
                    text: 'Lab Test',
                    textStyle: TextStyle(
                      fontSize: AppSizes.fontSize16,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.bold,
                    ),
                    iconSize: AppSizes.iconSize25),
                GButton(
                    icon: Icons.web,
                    text: 'Berita',
                    textStyle: TextStyle(
                      fontSize: AppSizes.fontSize16,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.bold,
                    ),
                    iconSize: AppSizes.iconSize25),
                GButton(
                    icon: Icons.history,
                    text: 'History',
                    textStyle: TextStyle(
                      fontSize: AppSizes.fontSize16,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.bold,
                    ),
                    iconSize: AppSizes.iconSize25),
                GButton(
                  icon: Icons.account_box_rounded,
                  text: 'Account',
                  textStyle: TextStyle(
                    fontSize: AppSizes.fontSize16,
                    fontFamily: AppFonts.nunito,
                    fontWeight: FontWeight.bold,
                  ),
                  iconSize: AppSizes.iconSize25,
                ),
              ],
              selectedIndex: controller.selectedIndex.value,
              onTabChange: (index) {
                controller.changeTab(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
