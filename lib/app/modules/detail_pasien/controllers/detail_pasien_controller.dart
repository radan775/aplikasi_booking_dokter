import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';
import 'package:get/get.dart';

class DetailPasienController extends GetxController {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final RxString selectedGender = ''.obs;
}
