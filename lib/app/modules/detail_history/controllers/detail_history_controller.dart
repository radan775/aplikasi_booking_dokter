import 'package:get/get.dart';

class DetailHistoryController extends GetxController {
  final RxMap<String, dynamic> historyData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Ambil data dari Get.arguments
    historyData.addAll(Get.arguments ?? {});
    print("Data diterima: $historyData");
  }
}
