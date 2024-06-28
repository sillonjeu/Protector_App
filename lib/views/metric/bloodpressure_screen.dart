import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/font_system.dart';
import '../../viewModels/metric/bloodpressure_viewmodel.dart';
import '../base/base_screen.dart';

class BloodPressureScreen extends BaseScreen<BloodPressureViewModel> {
  const BloodPressureScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final BloodPressureViewModel viewModel = Get.find<BloodPressureViewModel>();

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
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: _buildTopContainer(context),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _buildAverageBloodPressureCard(context),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: _buildBloodPressureCard(context),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: _buildWarningCard(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopContainer(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Text(
                '혈압',
                style: FontSystem.KR22B.copyWith(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAverageBloodPressureCard(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth - 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFCDA6FF),
            Color(0xFF2663FF),
          ],
        ),
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 자식들을 왼쪽으로 정렬
        children: <Widget>[
          Text(
            '한달 간 평균 혈압',
            style: FontSystem.KR22B.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10), // 텍스트와 박스 사이의 간격
          Container(
            width: screenWidth - 80,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0x1AFFFFFF), // 10% 투명도의 흰색
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center( // 텍스트를 컨테이너 내 중앙에 정렬
              child: Text(
                // Todo: 연동
                '-/-', // 작은 컨테이너 안의 텍스트
                style: FontSystem.KR35B.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodPressureCard(BuildContext context) {
    final BloodPressureViewModel viewModel = Get.find<BloodPressureViewModel>();
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth - 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 10),
          )
        ],
      ),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Image.asset('assets/images/bloodpressure.png', width: 25, height: 25),
              SizedBox(width: 5,),
              Text('한달 간 혈압 측정 그래프', style: FontSystem.KR16B.copyWith(color: Colors.black)),
            ],
          ),
          SizedBox(height: 8),
          Center( // 중앙 정렬을 위해 Center 위젯 사용
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFFA295FF), Color(0xFF1C336E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                '-', // Todo: 연동 필요
                style: FontSystem.KR42B.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard(BuildContext context) {
    final BloodPressureViewModel viewModel = Get.find<BloodPressureViewModel>();
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth - 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 10),
          )
        ],
      ),
      padding: const EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 32),
      child: Center(
        child: Align(
          alignment: Alignment.center,
          child: RichText(
            textAlign: TextAlign.center, // 텍스트 중앙 정렬
            text: TextSpan(
              children: [
                TextSpan(
                  text: '오늘은 - 일 전보다 - 정도 높아요\n', // Todo: 연동 필요
                  style: FontSystem.KR20B.copyWith(color: Colors.black),
                ),
                TextSpan(
                  text: '관리에 유의해 주세요!',
                  style: FontSystem.KR20B.copyWith(color: Colors.black), // 다른 스타일 적용 예시
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}