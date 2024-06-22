import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../viewModels/telemedicine/telemedicine_viewmodel.dart';
import '../base/base_screen.dart';

class TelemedicineScreen extends BaseScreen<TelemedicineViewModel> {
  const TelemedicineScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: solutionCard(),
              ),
              // 다른 컨테이너 추가 가능
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}

class solutionCard extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(22.96, 18.36, 22.96, 0),
      height: 119.94, // 전체 컨테이너의 높이를 119.94로 고정
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 50,
            spreadRadius: 0,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 자식들 사이의 공간을 균등하게 분배
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SvgPicture.asset(device.icon, width: 29.84, height: 29.84),
                SizedBox(width: 13.2,),
                Expanded(
                  child: Text("테스트", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: 66, // 버튼의 너비를 설정
                  height: 25.2, // 버튼의 높이를 설정
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.36), // 테두리 둥글게 처리
                  ),// 버튼의 높이를 조정
                  child: TextButton(
                    onPressed: () {},
                    child: Text('수정', style: TextStyle(fontSize: 11.8, color: Color(0xFF9A9B9E))),
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF9A9B9E), backgroundColor: Color(0xFFF7F7F9),
                      padding: EdgeInsets.symmetric(horizontal: 5), // 버튼 내부 여백 조정
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("12", style: TextStyle(fontSize: 13.77, color: Colors.black)),
                Container(
                  width: 66, // 버튼의 너비를 설정
                  height: 25.2, // 버튼의 높이를 설정
                  decoration: BoxDecoration(
                    color: Colors.white, // 배경색 설정
                    border: Border.all(
                        color: Color(0xFFF7F7F9), // 테두리 색상
                        width: 2.3 // 테두리 너비
                    ),
                    borderRadius: BorderRadius.circular(18.36), // 테두리 둥글게 처리
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text('삭제', style: TextStyle(fontSize: 11.8, color: Color(0xFF9A9B9E))),
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF9A9B9E), backgroundColor: Colors.transparent, // 버튼 누름 효과 색상
                      padding: EdgeInsets.symmetric(horizontal: 5), // 버튼 내부 여백 조정
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 누르는 영역을 콘텐츠에 맞춤
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // 버튼의 둥근 모서리 설정
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}