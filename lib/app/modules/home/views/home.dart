import 'package:aplikasi_booking_dokter/app/data/consts/colors.dart';
import 'package:aplikasi_booking_dokter/app/modules/category_view/category_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/home/views/home_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/login/views/login_view.dart';
import 'package:aplikasi_booking_dokter/app/modules/setting_view/setting_view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List screenList = [
    HomeView(),
    CategoryView(),
    LoginView(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white.withOpacity(0.5),
          selectedItemColor: AppColors.whiteColor,
          selectedLabelStyle: TextStyle(
            color: AppColors.whiteColor,
          ),
          selectedIconTheme: IconThemeData(
            color: AppColors.whiteColor,
          ),
          backgroundColor: AppColors.blueColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Category"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Doctor"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ]),
    );
  }
}
