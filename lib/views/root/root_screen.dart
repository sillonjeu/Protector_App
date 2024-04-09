import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanieum/views/doctor/doctor_screen.dart';
import 'package:hanieum/views/telemedicine/telemedicine_screen.dart';
import '../../viewModels/root/root_viewmodel.dart';
import '../base/base_screen.dart';
import '../home/home_screen.dart';
import 'custom_bottom_navigation_bar.dart';

class RootScreen extends BaseScreen<RootViewModel> {
  const RootScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    print(viewModel.selectedIndex);
    return Obx(
      () => IndexedStack(
        index: viewModel.selectedIndex,
        children: [
          HomeScreen(), // 0
          TelemedicineScreen(), // 1
          DoctorScreen(), // 2
        ],
      ),
    );
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    return const CustomBottomNavigationBar();
  }

  @override
  bool get extendBodyBehindAppBar => true;

  @override
  Color? get unSafeAreaColor => const Color(0xFF0D0B26);

  @override
  bool get setTopOuterSafeArea => false;
}
