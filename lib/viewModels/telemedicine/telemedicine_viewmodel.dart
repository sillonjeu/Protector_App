import 'package:get/get.dart';
import 'package:hanieum/models/telemedicine/telemedicine_model.dart';
import 'package:hanieum/services/telemedicine/telemedicine_service.dart';

class TelemedicineViewModel extends GetxController {
  var telemedicinesList = <Telemedicine>[].obs;
  late final TelemedicineService service;

  TelemedicineViewModel({required this.service});

  @override
  void onInit() {
    super.onInit();
    fetchTelemedicines();
  }

  void fetchTelemedicines() async {
    try {
      // 서버 호출 대신 더미 데이터 생성
      var fetchTelemedicines = List.generate(12, (index) => Telemedicine(
          medicalHistoryId: index,
          doctorId: index,
          prescription: 'https://seoul.intercontinental.com/upload/file/commonfilelang/15/800.pdf',
          diagnoise: 'https://seoul.intercontinental.com/upload/file/commonfilelang/15/800.pdf',
          visitAt: DateTime.now()
      ));
      telemedicinesList.assignAll(fetchTelemedicines);

      // 실제 API 사용 시 주석 해제
      // var service = TelemedicineService();
      // var fetchedDoctors = await service.fetchTelemedicines();
      // telemedicinesList.assignAll(fetchTelemedicines);
    } catch (e) {
      // 에러 처리
      Get.snackbar('Error', 'Failed to fetch telemedicine data');
    }
  }

  void launchPDF(String url) async {
    try {
      await service.openPDF(url);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}