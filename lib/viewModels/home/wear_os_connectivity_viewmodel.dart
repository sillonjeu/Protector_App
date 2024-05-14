import 'package:flutter_wear_os_connectivity/models/index.dart';
import 'package:get/get.dart';
import '../../services/home_service.dart';

class WearOsConnectivityViewModel extends GetxController {
  final WearOsService _service = WearOsService();
  final RxList<WearOsDevice> connectedDevices = <WearOsDevice>[].obs;
  final RxString messageStatus = 'Ready to send message'.obs;

  @override
  void onInit() {
    super.onInit();
    initializeService();
    fetchConnectedDevices();
  }

  void initializeService() async {
    await _service.initialize();
  }

  void fetchConnectedDevices() async {
    try {
      var devices = await _service.getConnectedDevices();
      connectedDevices.assignAll(devices as Iterable<WearOsDevice>);  // 'as' 캐스팅 제거
    } catch (e) {
      messageStatus.value = "Failed to fetch devices: $e";
    }
  }

  void sendMessage(String deviceId) async {
    if (connectedDevices.isEmpty) {
      messageStatus.value = "No connected devices available";
      return;
    }
    try {
      var result = await _service.sendMessage("Hello from Flutter", deviceId);
      messageStatus.value = result;
    } catch (e) {
      messageStatus.value = "Failed to send message: $e";
    }
  }
}
