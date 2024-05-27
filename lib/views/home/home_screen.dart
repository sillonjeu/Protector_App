import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanieum/views/home/wear_os_connectivity_screen.dart';
import '../../models/home_model.dart';
import '../../utilities/font_system.dart';
import '../../viewModels/home/home_viewmodel.dart';
import '../../viewModels/root/root_viewmodel.dart';
import '../base/base_screen.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final HomeViewModel viewModel = Get.find<HomeViewModel>();

    return Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: _testConnectWearOS(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: _testDoctorScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopContainer(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '안녕하세요, 환영합니다 👋',
        style: FontSystem.KR22B.copyWith(color: Colors.black),
      ),
    );
  }

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
                style: FontSystem.KR10B.copyWith(color: Colors.white),
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

  Widget _buildHorizontalListView(BuildContext context, List<DrugDose> drugDoseList) {
    return SizedBox(
      height: 200, // 수평 스크롤 뷰의 적절한 높이 설정, 카드와 패딩을 고려하여 조정
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.95), // viewportFraction은 한 번에 보이는 페이지의 비율입니다.
        itemCount: drugDoseList.length,
        itemBuilder: (context, index) {
          final drugDose = drugDoseList[index];
          return _buildReminderCard(context, drugDose);
        },
      ),
    );
  }

  Widget _buildReminderCard(BuildContext context, DrugDose drugDose) {
    return Container(
      width: MediaQuery.of(context).size.width - 40, // 너비 설정
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
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
          const SizedBox(height: 8),
          Center( // 중앙 정렬을 위해 Center 위젯 사용
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFFA295FF), Color(0xFF1C336E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                '08:00', // 알람 시간, 연동 필요
                style: FontSystem.KR42B.copyWith(color: Colors.white),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Switch(
                      value: drugDose.alarm, // 알람 설정 여부
                      onChanged: (bool value) {
                        // 알람 설정을 토글하는 함수 호출
                        // 예: viewModel.toggleAlarm(drugDose.drugCode);
                      },
                      activeColor: Colors.white, // 활성 상태일 때의 슬라이더 색상
                      activeTrackColor: Colors.green, // 활성 상태일 때의 트랙 색상
                      inactiveThumbColor: Colors.grey, // 비활성 상태일 때의 슬라이더 색상
                      inactiveTrackColor: Colors.grey.shade300, // 비활성 상태일 때의 트랙 색상
                    ),
                    Text(
                      drugDose.alarm ? ' 알람 활성' : ' 알람 비활성', // 상태에 따라 텍스트 변경
                      style: FontSystem.KR15B.copyWith(color: drugDose.alarm ? Colors.green : const Color(0xFF949BA7)),
                    ),
                  ],
                ),
              ),
              Text('처방 시간: ${drugDose.durationDay}일 전', style: FontSystem.KR15R.copyWith(color: const Color(0xFF949BA7))),
            ],
          )
        ],
      ),
    );
  }

  Widget _testConnectWearOS() {
    return ElevatedButton(
      onPressed: () {
        // GetX의 네비게이션 기능을 사용하여 WearOsConnectivityScreen으로 이동
        Get.to(() => WearOsConnectivityScreen());
      },
      child: const Text('Connect to Wear OS'),
    );
  }

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
