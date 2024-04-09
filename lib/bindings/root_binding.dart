import 'package:get/get.dart';
import 'package:hanieum/viewModels/doctor/doctor_viewmodel.dart';
import 'package:hanieum/viewModels/telemedicine/telemedicine_viewmodel.dart';
import '../services/home_service.dart';
import '../viewModels/home/home_viewmodel.dart';
import '../viewModels/root/root_viewmodel.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // ParentViewModel is singleton
    Get.put(RootViewModel());
    // ChildViewModel is singleton
    Get.lazyPut(() => PatientDrugService());
    Get.lazyPut(() => HomeViewModel(service: Get.find()));
    Get.lazyPut(() => TelemedicineViewModel());
    Get.lazyPut(() => DoctorViewModel());
  }
}