import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/home/home_model.dart';
import '../../utilities/font_system.dart';
import '../../viewModels/home/home_viewmodel.dart';
import '../base/base_screen.dart';

class CheckDoctorScreen extends BaseScreen<HomeViewModel> {
  const CheckDoctorScreen({super.key});

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
        child: _Container(),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}

class _Container extends StatelessWidget {
  const _Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25), // 모든 방향에 대해 20의 패딩 적용
      child: Container(
        width: MediaQuery.of(context).size.width - 40, // 패딩을 제외한 너비 설정
        height: MediaQuery.of(context).size.height - 40, // 패딩을 제외한 높이 설정
        decoration: BoxDecoration(
          color: Colors.white, // 배경을 흰색으로 변경
          borderRadius: BorderRadius.circular(16), // 모서리 곡률 16으로 설정
        ),
        padding: const EdgeInsets.all(20), // 컨테이너 안의 글자에 패딩 20 적용
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: FontSystem.KR20B.copyWith(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(text: '먼저,\n'),
                  TextSpan(
                    text: '주치의',
                    style: FontSystem.KR20B.copyWith(color: Color(0xFF2663FF),),
                  ),
                  TextSpan(text: ' 선생님과 연결해 주세요.\n\n병원에서 진단 받은 나의 병에 대한 '),
                  TextSpan(
                    text: '솔루션',
                    style: FontSystem.KR20B.copyWith(color: Color(0xFF2663FF),),
                  ),
                  TextSpan(text: '이 알고 싶거나,\n\n이전에 받았던 '),
                  TextSpan(
                    text: '처방전',
                    style: FontSystem.KR20B.copyWith(color: Color(0xFF2663FF),),
                  ),
                  TextSpan(text: ' 및 '),
                  TextSpan(
                    text: '진단서',
                    style: FontSystem.KR20B.copyWith(color: Color(0xFF2663FF),),
                  ),
                  TextSpan(text: '를 확인할 수 있어요.'),
                ],
              ),
            ),
            SizedBox(height: 50), // 텍스트와 이미지 사이에 간격 추가
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.60, // 가로 1:1 비율 설정
                height: MediaQuery.of(context).size.width * 0.60, // 세로 1:1 비율 설정
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/doctor_connect.png'), // 이미지 경로
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            _PatientCode(),
          ],
        ),
      ),
    );
  }
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