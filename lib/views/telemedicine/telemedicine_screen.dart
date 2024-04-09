import 'package:flutter/material.dart';
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
                child: Center(
                  child: Text('진료 내역 스크린', style: TextStyle(color: Colors.black, fontSize: 24)),
                ),
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