import 'package:flutter/material.dart';
import '../../utilities/font_system.dart';
import '../../viewModels/home/home_viewmodel.dart';
import '../base/base_screen.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: _buildTopContainer(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildCodeCard(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: _buildGrid(context),
          ),
        ],
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
  
  Widget _buildGrid(BuildContext context) {
    // 상태 버튼 그리드
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // 스크롤 안되게 고정
      children: List.generate(8, (index) {
        // 상태에 따라 아이콘 변경
        IconData iconData = Icons.check_circle_outline;
        Color color = Colors.green;
        String text = '확인';
        if (index % 3 == 1) {
          iconData = Icons.error_outline;
          color = Colors.red;
          text = '경고';
        }
        return _buildStatusButton(iconData, color, text);
      }),
    );
  }

  Widget _buildStatusButton(IconData iconData, Color color, String text) {
    // 각 상태 버튼
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(iconData, size: 50, color: color),
            Text(text, style: TextStyle(fontSize: 16)),
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
