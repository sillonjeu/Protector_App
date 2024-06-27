import 'package:get/get.dart';
import 'package:hanieum/services/doctor/doctor_service.dart';
import 'package:hanieum/services/telemedicine/telemedicine_service.dart';
import 'package:hanieum/viewModels/doctor/doctor_viewmodel.dart';
import 'package:hanieum/viewModels/metric/bloodpressure_viewmodel.dart';
import 'package:hanieum/viewModels/telemedicine/telemedicine_viewmodel.dart';
import '../services/home/home_service.dart';
import '../viewModels/home/home_viewmodel.dart';
import '../viewModels/home/wear_os_connectivity_viewmodel.dart';
import '../viewModels/root/root_viewmodel.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // ParentViewModel is singleton
    Get.put(RootViewModel());
    // ChildViewModel is singleton
    Get.lazyPut(() => PatientDrugService());
    Get.lazyPut(() => HomeViewModel(service: Get.find()));
    Get.lazyPut(() => TelemedicineViewModel(service: TelemedicineService()));
    Get.lazyPut(() => DoctorViewModel(service: Get.find()));
    Get.lazyPut(() => BloodPressureViewModel());
    Get.lazyPut(() => DoctorService());
    Get.lazyPut(() => TelemedicineService());
    Get.lazyPut(() => WearOsConnectivityViewModel());
  }
}