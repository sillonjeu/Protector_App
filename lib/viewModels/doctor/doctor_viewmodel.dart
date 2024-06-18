import 'package:get/get.dart';
import '../../models/doctor/doctor_model.dart';
import '../../services/doctor/doctor_service.dart';

class DoctorViewModel extends GetxController {
  var doctorsList = <Doctor>[].obs;
  final DoctorService service;

  DoctorViewModel({required this.service});

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  void fetchDoctors() async {
    try {
      // 서버 호출 대신 더미 데이터 생성
      var fetchedDoctors = List.generate(12, (index) => Doctor(
          licenseNumber: 'licenseNumber$index'
      ));
      doctorsList.assignAll(fetchedDoctors);

      // 실제 API 사용 시 주석 해제
      // var fetchedDoctors = await service.fetchDoctors();
      // doctorsList.assignAll(fetchedDoctors);
    } catch (e) {
      // 에러 처리
      Get.snackbar('Error', 'Failed to fetch doctors data');
    }
  }
}