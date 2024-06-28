import 'package:get/get.dart';
import '../bindings/root_binding.dart';
import '../views/home/home_screen.dart';
import '../views/metric/bloodpressure_screen.dart';
import '../views/metric/ecg_heartrate_screen.dart';
import '../views/root/root_screen.dart';
import 'app_routes.dart';

List<GetPage> appPages = [
  GetPage(
    name: Routes.ROOT,
    page: () => const RootScreen(),
    binding: RootBinding(),
  ),
  GetPage(
    name: Routes.HOME,
    page: () => const HomeScreen(),
    binding: RootBinding(),
  ),
  GetPage(
    name: Routes.BLOOD_PRESSURE,
    page: () => const BloodPressureScreen(),
    binding: RootBinding(),
  ),
  GetPage(
    name: Routes.ECG_HEARTRATE,
    page: () => const EcgHeartrateScreen(),
    binding: RootBinding(),
  ),
];
