import 'package:get/get.dart';

class DetailLabTestController extends GetxController {
  final labTestData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    labTestData.value = Get.arguments;
  }
}
