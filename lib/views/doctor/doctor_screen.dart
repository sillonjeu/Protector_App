import 'package:flutter/material.dart';
import '../../utilities/font_system.dart';
import '../../viewModels/doctor/doctor_viewmodel.dart';
import '../base/base_screen.dart';

class DoctorScreen extends BaseScreen<DoctorViewModel> {
  const DoctorScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: const Center(
                  child: Text('의사 스크린', style: TextStyle(color: Colors.black, fontSize: 24)),
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

class _PatientCode extends StatelessWidget {
  const _PatientCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFF2663FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          // Todo: 연동하기
          'X0E1F5GJ',
          style: FontSystem.KR30B.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}