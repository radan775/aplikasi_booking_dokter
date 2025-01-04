import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  Rx<Color> backgroundColor = Colors.orangeAccent.obs; //Colors.pinkAccent.obs

  void changeBackgroundColor(Color color) {
    backgroundColor.value = color;
  }
}
