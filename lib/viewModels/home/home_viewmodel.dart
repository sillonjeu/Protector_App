import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../../models/home/home_model.dart';
import '../../services/home/home_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class HomeViewModel extends GetxController {
  var summary = PatientDrugMetricSummaryDto().obs;
  late final PatientDrugService service;
  //그래프 관련 로직
  final RxList<FlSpot> flSpots = <FlSpot>[].obs;
  final RxDouble maxY = 0.0.obs;
  final RxString dataType = ''.obs;
  RxDouble maxYValue = 10.0.obs;
  var isLoading = true.obs;

  final RxList<FlSpot> systolicDataPoints = <FlSpot>[].obs;
  final RxList<FlSpot> diastolicDataPoints = <FlSpot>[].obs;


  HomeViewModel({required this.service});

  @override
  void onInit() {
    super.onInit();
    fetchSummary();
  }

  void fetchSummary() async {
    try {
      // 서버 호출 대신 더미 데이터 생성
      var fetchedSummary = PatientDrugMetricSummaryDto(
        drugDoseList: List.generate(5, (index) =>
            DrugDose(
              drugCode: 'drugCode$index',
              drugName: '혈압약 ',
              singleDose: 1.0 * index,
              dosesPerDay: 3,
              durationDay: 7,
              description: 'This is a description for Drug Name $index',
              alarm: index % 2 == 0,
              alarmType: 'Type $index',
              // alarmTime: '09:00 AM', // 예시로 시간을 문자열로 설정
            )),
        patientName: PatientName(name: 'John Doe'),
        metricSummary: [],
      );
      summary.value = fetchedSummary;
    } catch (e) {
      // 에러 처리
      Get.snackbar('Error', 'Failed to fetch data');
    }
  }

// Todo: 나중에 연동하기
// void fetchSummary() async {
//   try {
//     var fetchedSummary = await service.fetchPatientDrugMetricSummary();
//     summary.value = fetchedSummary;
//   } catch (e) {
//     // 에러 처리
//     Get.snackbar('Error', 'Failed to fetch data');
//   }
// }

  void toggleAlarm(String drugCode) {
    var drugDoseList = summary.value.drugDoseList;
    if (drugDoseList != null) {
      var index = drugDoseList.indexWhere((drugDose) => drugDose.drugCode == drugCode);
      if (index != -1) {
        drugDoseList[index].alarm = !drugDoseList[index].alarm;
        summary.update((val) {
          val?.drugDoseList = drugDoseList;
        });
      }
    }
  }

  //그래프 관련 로직
  void processJsonData(String jsonData, String dataType) {
    this.dataType.value = dataType;
    final data = json.decode(jsonData);
    List<FlSpot> spots = [];
    double maxValue = 0;

    if (dataType == 'HeartRate') {
      spots = _processHeartRateData(data);
    } else if (dataType == 'OxygenSaturation') {
      spots = _processOxygenSaturationData(data);
    } else if (dataType == 'RespiratoryRate') {
      spots = _processRespiratoryRateData(data);
    } else if (dataType == 'RestingHeartRate') {
      spots = _processRestingHeartRateData(data);
    } else if (dataType == 'SDNN') {
      spots = _processSDNNData(data);
    }

    for (var spot in spots) {
      if (spot.y > maxValue) maxValue = spot.y;
    }

    flSpots.value = spots;
    maxY.value = maxValue;
  }

  List<FlSpot> _processHeartRateData(List<dynamic> data) {
    return data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value['average'].toDouble());
    }).toList();
  }

  List<FlSpot> _processOxygenSaturationData(List<dynamic> data) {
    return data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value['value'] * 100);
    }).toList();
  }

  List<FlSpot> _processRespiratoryRateData(List<dynamic> data) {
    return data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value['value'].toDouble());
    }).toList();
  }

  List<FlSpot> _processRestingHeartRateData(List<dynamic> data) {
    return data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value['value'].toDouble());
    }).toList();
  }
  void processBloodPressureData(String jsonData) {
    dataType.value = 'BloodPressure';
    final data = json.decode(jsonData) as List<dynamic>;

    systolicDataPoints.value = data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value['systolic'].toDouble());
    }).toList();

    diastolicDataPoints.value = data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value['diastolic'].toDouble());
    }).toList();

    maxY.value = data.map((item) => item['systolic'] as int).reduce((max, value) => max > value ? max : value).toDouble();
  }
  List<FlSpot> _processSDNNData(List<dynamic> data) {
    return data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value['value'].toDouble());
    }).toList();
  }


}