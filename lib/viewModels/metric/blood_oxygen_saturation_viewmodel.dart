import 'package:get/get.dart';
import 'package:health/health.dart';

class BloodOxygenSaturationViewModel extends GetxController {
  // 혈중 산소포화도 데이터를 저장할 리스트
  var bloodOxygenData = <HealthDataPoint>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBloodOxygenData();
  }

  // HealthKit에서 혈중 산소포화도 데이터를 가져오는 함수
  Future<void> fetchBloodOxygenData() async {
    final now = DateTime.now();
    final health = HealthFactory();

    final types = [HealthDataType.BLOOD_OXYGEN];

    try {
      // HealthKit 권한 요청
      bool requested = await health.requestAuthorization(types);
      if (!requested) {
        throw Exception('Authorization not granted');
      }

      // 7일 동안의 혈중 산소포화도 데이터를 가져옴
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        now.subtract(Duration(days: 7)),
        now,
        types,
      );

      // 데이터를 리스트에 저장
      bloodOxygenData.assignAll(healthData);
    } catch (error) {
      // 에러가 발생했을 때 에러 메시지를 상세히 출력
      print('Error during HealthKit authorization or data retrieval: $error');
    } finally {
      // 로딩 상태 해제
      isLoading.value = false;
    }
  }
}
