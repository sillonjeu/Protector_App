import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../models/doctor/doctor_model.dart';
import '../../utilities/font_system.dart';
import '../../viewModels/doctor/doctor_viewmodel.dart';
import '../base/base_screen.dart';

class DoctorScreen extends BaseScreen<DoctorViewModel> {
  const DoctorScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    // Fetching the ViewModel using GetX dependency injection
    final DoctorViewModel viewModel = Get.find<DoctorViewModel>();
    return Container(
      height: Get.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD9E8F7), Color(0xFFFFFFFF)],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 20, 20),
              child: _buildTopContainer(),
            ),
            Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: viewModel.doctorsList.length,
              itemBuilder: (context, index) {
                final doctor = viewModel.doctorsList[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: _DoctorContainer(doctor: doctor),
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}

class _DoctorContainer extends StatelessWidget {
  final Doctor doctor;
  const _DoctorContainer({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10), // Padding for inner contents
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              'assets/icons/doctor.svg',
              width: 40,
              height: 40,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                doctor.licenseNumber, // Displaying the doctor's license number
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,  // Handle possible overflow
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildTopContainer extends StatelessWidget {
  const _buildTopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/doctor.svg',  // SVG 파일 경로
            width: 24,  // 이미지 너비
            height: 24,  // 이미지 높이
          ),
          SizedBox(width: 8),
          Text(
            '내 주치의 선생님들',
            style: FontSystem.KR22B.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
