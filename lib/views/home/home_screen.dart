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
              // Null 체크 추가
              var drugDoseList = viewModel.summary.value.drugDoseList;
              if (drugDoseList == null || drugDoseList.isEmpty) {
                return _ifAlarmIsEmpty(context);
              }
              return ListView.builder(
                shrinkWrap: true, // Column 내부에서 ListView 사용시 필요
                physics: NeverScrollableScrollPhysics(), // 내부 ListView 스크롤 방지
                itemCount: drugDoseList.length,
                itemBuilder: (context, index) {
                  final drugDose = drugDoseList[index];
                  return _buildReminderCard(context, drugDose);
                },
              );
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

  Widget _buildReminderCard(BuildContext context, DrugDose drugDose) {
    return Dismissible(
      key: Key(drugDose.drugCode), // 고유한 key를 약 코드로 설정
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        // 알람을 삭제하는 등의 동작을 구현
        // viewModel.removeAlarm(drugDose.drugCode); 가 호출되어야 함
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(drugDose.drugName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                SvgPicture.asset('assets/icons/medicine.svg'), // SVG 이미지 사용
              ],
            ),
            SizedBox(height: 8),
            Text(
              // Todo: 연동
              '08: 00', // drugDose.alarmTime,
              style: TextStyle(color: Colors.blue, fontSize: 40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('처방 시간: ${drugDose.durationDay} 일', style: TextStyle(fontSize: 12)),
                Checkbox(
                  value: drugDose.alarm, // 알람 설정 여부
                  onChanged: (bool? value) {
                    // 여기서 알람 설정을 토글하는 함수를 호출해야 함
                    // 예: viewModel.toggleAlarm(drugDose.drugCode);
                  },
                ),
              ],
            ),
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
