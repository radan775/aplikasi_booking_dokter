import 'dart:ui';

import 'package:aplikasi_booking_dokter/app/data/consts/colors.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await listenToEventChanges();
  }

  Future<void> listenToEventChanges() async {
    FirebaseFirestore.instance
        .collection('events')
        .doc('2T1ge3YWC7k2B1Erap6d')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final event = snapshot.data()?['event'] ?? 'Tidak ada';
        updateAppColors(event);
      }
    });
  }

  void updateAppColors(String event) {
    if (event.toLowerCase() == 'bulan agustus') {
      AppColors.blueColor = const Color(0xFFD71313);
      AppColors.blueAccentColor = const Color(0xFFBAD7E9);
    } else if (event.toLowerCase() == 'hari ibu') {
      AppColors.blueColor = const Color(0xFFE195AB);
      AppColors.blueAccentColor = const Color(0xFFFFCCE1);
    } else {
      AppColors.initializeDefaultColors();
    }
    update();
  }
}
