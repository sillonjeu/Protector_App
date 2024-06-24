import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../models/telemedicine/telemedicine_model.dart';
import '../../utilities/font_system.dart';
import '../../viewModels/telemedicine/telemedicine_viewmodel.dart';
import '../base/base_screen.dart';

class TelemedicineScreen extends BaseScreen<TelemedicineViewModel> {
  const TelemedicineScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final TelemedicineViewModel viewModel = Get.find<TelemedicineViewModel>();
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
              padding: const EdgeInsets.fromLTRB(10, 30, 20, 20),
              child: _buildTopContainer(),
            ),
            Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: viewModel.telemedicinesList.length,
              itemBuilder: (context, index) {
                final telemedicine = viewModel.telemedicinesList[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SolutionCard(
                    telemedicine: telemedicine,
                    index: index, // 인덱스를 전달
                  ),
                );
              },
            )),
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

class SolutionCard extends StatelessWidget {
  final Telemedicine telemedicine;
  final int index; // 인덱스 추가
  final TelemedicineViewModel viewModel = Get.find<TelemedicineViewModel>();

  SolutionCard({Key? key, required this.telemedicine, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 15),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/icons/medicine.png',
                  width: 20,  // 이미지 너비
                  height: 20,  // 이미지 높이
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Text(telemedicine.getFormattedVisitDate(), style: FontSystem.KR16B.copyWith(color: Colors.black)),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 15), // 여기에 버튼의 외부 패딩 조정
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2663FF), // 버튼 배경색
                onPrimary: Colors.white, // 버튼의 텍스트 색상
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // 버튼의 곡률
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // 여기에 버튼 내부 패딩 조정
                minimumSize: Size(double.infinity, 36), // 버튼의 최소 크기 설정
              ),

              onPressed: () {
                viewModel.fetchTelemedicineDetails(telemedicine.medicalHistoryId);
                // Todo: VM Test : print(telemedicine.medicalHistoryId);
                Get.defaultDialog(
                  titlePadding: EdgeInsets.zero,
                  backgroundColor: Color(0xFFFFFFFF),
                  title: '',
                  content: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 300, // 위 아래 각각 80의 패딩을 제외한 높이
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Obx(() {
                          if (viewModel.telemedicinesdetailsList.isEmpty) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/medicine.png',
                                      width: 24,  // 이미지 너비
                                      height: 24,  // 이미지 높이
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '솔루션',
                                      style: FontSystem.KR20B.copyWith(color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),  // 이미지와 텍스트 사이의 간격
                                Text(
                                  viewModel.telemedicinesdetailsList.first.description,
                                  style: FontSystem.KR16R.copyWith(color: Colors.black),
                                  textAlign: TextAlign.start, // 텍스트 정렬
                                ),
                              ],
                            );
                          }
                        }),
                      ),
                    ),
                  ),
                  textConfirm: '닫기',
                  onConfirm: () {
                    Get.back();
                  },
                );
              },

              child: Text('솔루션 보기', style: FontSystem.KR20B.copyWith(color: Colors.white)), // 버튼 텍스트
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
                TextButton(
                  onPressed: () => viewModel.launchPDF(telemedicine.prescription),
                  child: Text('처방전', style: FontSystem.KR20B.copyWith(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () => viewModel.launchPDF(telemedicine.diagnoise),
                  child: Text('진단서', style: FontSystem.KR20B.copyWith(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _buildTopContainer extends StatelessWidget {
  const _buildTopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/medical_history.png',
            width: 24,  // 이미지 너비
            height: 24,  // 이미지 높이
          ),
          SizedBox(width: 8),
          Text(
            '진료 내역',
            style: FontSystem.KR22B.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}