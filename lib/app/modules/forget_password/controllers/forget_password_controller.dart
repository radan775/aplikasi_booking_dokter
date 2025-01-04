import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  var emailController = TextEditingController();
  var codeController = TextEditingController();
  var isCodeSent = false.obs;
  var isTimerExpired = false.obs;
  var timerDisplay = '60s'.obs;

  void sendResetCode() {
    isCodeSent.value = true;
  }

  void resendCode() {
    startCountdown();
  }

  void startCountdown() {
    isTimerExpired.value = false;
    timerDisplay.value = '60s';
    int countdown = 60;

    Timer.periodic(Duration(seconds: 1), (timer) {
      countdown--;
      timerDisplay.value = '$countdown s';
      // Ketika waktu habis
      if (countdown <= 0) {
        isTimerExpired.value = true;
        timerDisplay.value = '00s';
        timer.cancel();
      }
    });
  }
}
