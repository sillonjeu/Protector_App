import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../models/doctor/doctor_model.dart';
import '../../utilities/font_system.dart';
import '../../viewModels/doctor/doctor_viewmodel.dart';
import '../base/base_screen.dart';

class DoctorScreen extends BaseScreen<DoctorViewModel> {
  const DoctorScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
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
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              SvgPicture.asset(
                'assets/icons/doctor.svg',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  doctor.name,
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '병원: ${doctor.hospital}',
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            '진단 코드: ${doctor.diagnosisCode}',
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            '면허 번호: ${doctor.licenseNumber}',
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ],
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
            'assets/icons/doctor.svg',
            width: 24,
            height: 24,
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
