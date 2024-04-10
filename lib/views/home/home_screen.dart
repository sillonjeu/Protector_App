import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../models/home_model.dart';
import '../../utilities/font_system.dart';
import '../../viewModels/home/home_viewmodel.dart';
import '../base/base_screen.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final HomeViewModel viewModel = Get.find<HomeViewModel>();

    return Container(
      decoration: BoxDecoration(
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
        gradient: LinearGradient(
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
              color: Color(0x1AFFFFFF), // 10% 투명도의 흰색
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
        shaderCallback: (bounds) => LinearGradient(
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
    return Container(
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
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // 카드 간 간격 및 정렬을 위한 마진
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(drugDose.drugName, style: FontSystem.KR16B.copyWith(color: Colors.black)),
              ),
              SvgPicture.asset('assets/icons/medicine.svg', width: 24, height: 24),
            ],
          ),
          SizedBox(height: 8),
          Center( // 중앙 정렬을 위해 Center 위젯 사용
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Color(0xFFA295FF), Color(0xFF1C336E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                '08:00', // 알람 시간, 연동 필요
                style: FontSystem.KR40B.copyWith(color: Colors.white),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: drugDose.alarm, // 알람 설정 여부
                onChanged: (bool? value) {
                  // 알람 설정을 토글하는 함수 호출
                  // 예: viewModel.toggleAlarm(drugDose.drugCode);
                },
              ),
              Text('처방 시간: ${drugDose.durationDay}일 전 ', style: FontSystem.KR15R.copyWith(color: Color(0xFF949BA7))),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}
