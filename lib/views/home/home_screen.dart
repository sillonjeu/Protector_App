import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanieum/views/home/wear_os_connectivity_screen.dart';
import '../../models/home/home_model.dart';
import '../../utilities/app_routes.dart';
import '../../utilities/font_system.dart';
import '../../viewModels/home/home_viewmodel.dart';
import '../../viewModels/root/root_viewmodel.dart';
import '../base/base_screen.dart';
import '../metric/bloodpressure_screen.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final HomeViewModel viewModel = Get.find<HomeViewModel>();

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
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: _buildCodeCard(context),
            ),
            Obx(() {
              var drugDoseList = viewModel.summary.value.drugDoseList;
              if (drugDoseList == null || drugDoseList.isEmpty) {
                return _ifAlarmIsEmpty(context);
              }
              return _buildHorizontalListView(context, drugDoseList);
            }),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Row(
                children: [
                  Expanded(child: _buildBloodPressureCard(context)),
                  SizedBox(width: 20),
                  Expanded(child: _buildStressSleepCard(context)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Row(
                children: [
                  Expanded(child: _buildElectrocardiogramHeartrateCard(context)),
                  SizedBox(width: 20),
                  Expanded(child: _buildBloodOxygenSaturationCard(context)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: _testDoctorScreen(),
            ),
          ],
        ),
      ),
    );
  }

  // 안녕하세요
  Widget _buildTopContainer(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '안녕하세요, 환영합니다 👋',
        style: FontSystem.KR22B.copyWith(color: Colors.black),
      ),
    );
  }

  // 환자 코드
  Widget _buildCodeCard(BuildContext context) {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline, // 이거 baseline 써먹기. 폰트 달라도 줄 맞출 수 있음
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                '환자코드  ',
                style: FontSystem.KR22B.copyWith(color: Colors.white),
              ),
              Text(
                '진찰하시는 의사에게 보여주세요',
                style: FontSystem.KR12B.copyWith(color: Colors.white),
              ),
            ],
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
                'X0E1F5GJ', // 작은 컨테이너 안의 텍스트
                style: FontSystem.KR35B.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 알람이 없을 때 화면
  Widget _ifAlarmIsEmpty(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40, // 너비 설정
      height: 110, // 높이 설정
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30), // 패딩 설정
      decoration: BoxDecoration(
        color: Colors.white, // 흰색 배경
        borderRadius: BorderRadius.circular(16), // 모서리 둥글게
      ),
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFA295FF), Color(0xFF1C336E)], // 그라데이션 색상
        ).createShader(bounds),
        child: Text(
          "알람이 없습니다!",
          textAlign: TextAlign.center,
          style: FontSystem.KR30B.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  // 알람을 보여주기 위한 리스트
  Widget _buildHorizontalListView(BuildContext context, List<DrugDose> drugDoseList) {
    return SizedBox(
      height: 185, // 수평 스크롤 뷰의 적절한 높이 설정, 카드와 패딩을 고려하여 조정
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.95), // viewportFraction은 한 번에 보이는 페이지의 비율
        itemCount: drugDoseList.length,
        itemBuilder: (context, index) {
          final drugDose = drugDoseList[index];
          return _buildReminderCard(context, drugDose);
        },
      ),
    );
  }

  // 알람 화면
  Widget _buildReminderCard(BuildContext context, DrugDose drugDose) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(drugDose.drugName, style: FontSystem.KR16B.copyWith(color: Colors.black)),
              ),
              Image.asset('assets/icons/medicine.png', width: 20, height: 20),
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
                '08:00', // Todo: 알람 시간, 연동 필요
                style: FontSystem.KR42B.copyWith(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      icon: Icon(
                        drugDose.alarm ? Icons.check_circle : Icons.cancel,
                        color: drugDose.alarm ? Colors.green : Colors.red,
                      ),
                      onPressed: () {
                        viewModel.toggleAlarm(drugDose.drugCode);
                      },
                    ),
                  ),
                  Container(
                    child: Text(
                      drugDose.alarm ? '알람 활성' : '알람 비활성', // 상태에 따라 텍스트 변경
                      style: FontSystem.KR16B.copyWith(color: drugDose.alarm ? Colors.green : Colors.red),
                    ),
                  ),
                ],
              ),
              Text('복용 기간: ${drugDose.durationDay}일', style: FontSystem.KR16R.copyWith(color: const Color(0xFF949BA7))),
            ],
          )
        ],
      ),
    );
  }

  // 혈압
  Widget _buildBloodPressureCard(BuildContext context) {
    final HomeViewModel viewModel = Get.find<HomeViewModel>();
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.BLOOD_PRESSURE);
      },
      child: Container(
        width: screenWidth / 2 - 40,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text('혈압', style: FontSystem.KR16B.copyWith(color: Colors.black)),
                ),
                Image.asset('assets/images/bloodpressure.png', width: 25, height: 25),
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
      ),
    );
  }

  // 스트레스, 수면
  Widget _buildStressSleepCard(BuildContext context) {
    final HomeViewModel viewModel = Get.find<HomeViewModel>();
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.STRESS_SLEEP);
      },
      child: Container(
        width: screenWidth / 2 - 40,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text('스트레스/수면', style: FontSystem.KR16B.copyWith(color: Colors.black)),
                ),
                Image.asset('assets/images/stresssleep.png', width: 20, height: 20),
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
                  '-/-', // Todo: 연동 필요
                  style: FontSystem.KR42B.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 심박수, 심전도
  Widget _buildElectrocardiogramHeartrateCard(BuildContext context) {
    final HomeViewModel viewModel = Get.find<HomeViewModel>();
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.ECG_HEARTRATE);
      },
      child: Container(
        width: screenWidth / 2 - 40,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text('심전도/심박수', style: FontSystem.KR16B.copyWith(color: Colors.black)),
                ),
                Image.asset('assets/images/electrocardiogramheartrate.png', width: 25, height: 25),
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
                  '-/-', // Todo: 연동 필요
                  style: FontSystem.KR42B.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 혈중 산소 포화
  Widget _buildBloodOxygenSaturationCard(BuildContext context) {
    final HomeViewModel viewModel = Get.find<HomeViewModel>();
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.BLOOD_OXYGEN_SATURATION);
      },
      child: Container(
        width: screenWidth / 2 - 40,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text('혈중 산소 포화', style: FontSystem.KR16B.copyWith(color: Colors.black)),
                ),
                Image.asset('assets/images/bloodoxygensaturation.png', width: 25, height: 25),
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
      ),
    );
  }

  // WearOs 연동 test
  Widget _testConnectWearOS() {
    return ElevatedButton(
      onPressed: () {
        // GetX의 네비게이션 기능을 사용하여 WearOsConnectivityScreen으로 이동
        Get.to(() => WearOsConnectivityScreen());
      },
      child: const Text('Connect to Wear OS'),
    );
  }

  // 주치의 연동 확인 스크린
  Widget _testDoctorScreen() {
    return ElevatedButton(
      onPressed: () {
        // GetX의 네비게이션 기능을 사용하여 WearOsConnectivityScreen으로 이동
        RootViewModel rootViewModel = Get.put(RootViewModel());
        rootViewModel.changeIndex(4);
      },
      child: const Text('Test Doctor Screen'),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}
