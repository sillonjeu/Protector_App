import 'package:get/get.dart';
import '../../models/home_model.dart';
import '../../services/home_service.dart';

class HomeViewModel extends GetxController {
  var summary = PatientDrugMetricSummaryDto().obs;
  late final PatientDrugService service;

  HomeViewModel({required this.service});

  @override
  void onInit() {
    super.onInit();
    fetchSummary();
  }

  void fetchSummary() async {
    try {
      // 서버 호출 대신 더미 데이터 생성
      var fetchedSummary = PatientDrugMetricSummaryDto(
        drugDoseList: List.generate(5, (index) => DrugDose(
          drugCode: 'drugCode$index',
          drugName: 'Drug Name $index',
          singleDose: 1.0 * index,
          dosesPerDay: 3,
          durationDay: 7,
          description: 'This is a description for Drug Name $index',
          alarm: index % 2 == 0,
          alarmType: 'Type $index',
          // alarmTime: '09:00 AM', // 예시로 시간을 문자열로 설정
        )),
        patientName: PatientName(name: 'John Doe'),
        metricSummary: [],
      );
      // summary.value = fetchedSummary;
    } catch (e) {
      // 에러 처리
      Get.snackbar('Error', 'Failed to fetch data');
    }
  }

  // Todo: 나중에 연동하기
  // void fetchSummary() async {
  //   try {
  //     var fetchedSummary = await service.fetchPatientDrugMetricSummary();
  //     summary.value = fetchedSummary;
  //   } catch (e) {
  //     // 에러 처리
  //     Get.snackbar('Error', 'Failed to fetch data');
  //   }
  // }

}