import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  var emailController = TextEditingController();
  var codeController = TextEditingController();
  var isCodeSent = false.obs;
  var isTimerExpired = false.obs;
  var timerDisplay = '60s'.obs;

  // Fungsi untuk mengirim kode reset
  void sendResetCode() {
    isCodeSent.value = true;
  }

  // Fungsi untuk mengirim ulang kode reset
  void resendCode() {
    // Logika untuk mengirim ulang kode reset
    startCountdown(); // Mulai countdown lagi
  }

  // Fungsi untuk memulai countdown 60 detik
  void startCountdown() {
    // Reset timer sebelum memulai
    isTimerExpired.value = false;
    timerDisplay.value = '60s'; // Set timer awal
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
