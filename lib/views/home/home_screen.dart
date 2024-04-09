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
    // 가운데 코드가 포함된 카드
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text('X0E1F5GJ', style: TextStyle(color: Colors.white, fontSize: 24)),
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
