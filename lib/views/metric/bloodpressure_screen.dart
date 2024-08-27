import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/font_system.dart';
import '../base/base_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import'../../models/home/dummy_data.dart';

class BloodPressureScreen extends StatelessWidget {
  const BloodPressureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
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
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: _buildTopContainer(context),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _buildAverageBloodPressureCard(context),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: _buildBloodPressureCard(context),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: _buildWarningCard(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopContainer(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Text(
                '혈압',
                style: FontSystem.KR22B.copyWith(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAverageBloodPressureCard(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth - 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFCDA6FF),
            Color(0xFF2663FF),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 10),
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '한달 간 평균 혈압',
            style: FontSystem.KR22B.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          Container(
            width: screenWidth - 80,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0x1AFFFFFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                _calculateAverageBloodPressure(),
                style: FontSystem.KR35B.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodPressureCard(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth - 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 10),
          )
        ],
      ),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Image.asset('assets/images/bloodpressure.png', width: 25, height: 25),
              SizedBox(width: 5,),
              Text('한달 간 혈압 측정 그래프', style: FontSystem.KR16B.copyWith(color: Colors.black)),
            ],
          ),
          SizedBox(height: 16),
          _buildBloodPressureChart(),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend(Colors.red, '수축기'),
              SizedBox(width: 20),
              _buildLegend(Colors.blue, '이완기'),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildBloodPressureChart() {
    List<Map<String, dynamic>> data = (json.decode(DummyData.bloodPressureData) as List<dynamic>)
        .cast<Map<String, dynamic>>();
    List<FlSpot> systolicSpots = [];
    List<FlSpot> diastolicSpots = [];
    double maxY = 0;

    for (int i = 0; i < data.length; i++) {
      systolicSpots.add(FlSpot(i.toDouble(), data[i]['systolic'].toDouble()));
      diastolicSpots.add(FlSpot(i.toDouble(), data[i]['diastolic'].toDouble()));
      maxY = maxY < data[i]['systolic'] ? data[i]['systolic'].toDouble() : maxY;
    }

    // 마지막 데이터 포인트의 값을 가져옵니다.
    int lastSystolic = data.last['systolic'];
    int lastDiastolic = data.last['diastolic'];

    return AspectRatio(
      aspectRatio: 1.70,
      child: Stack(
        children: [
          LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: data.length.toDouble() - 1,
              minY: 0,
              maxY: maxY + 10,
              lineBarsData: [
                LineChartBarData(
                  spots: systolicSpots,
                  isCurved: true,
                  color: Colors.red.withOpacity(0.8),
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.red.withOpacity(0.1),
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withOpacity(0.4),
                        Colors.red.withOpacity(0.1),
                      ],
                      stops: const [0.1, 1.0],
                    ),
                  ),
                ),
                LineChartBarData(
                  spots: diastolicSpots,
                  isCurved: true,
                  color: Colors.blue.withOpacity(0.8),
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.blue.withOpacity(0.1),
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.4),
                        Colors.blue.withOpacity(0.1),
                      ],
                      stops: const [0.1, 1.0],
                    ),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(enabled: false),
              backgroundColor: Colors.white,
            ),
          ),
          Positioned(
            bottom: 10,
            left: -60,
            right: 0,
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$lastSystolic / $lastDiastolic ',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF38435E),
                      ),
                    ),
                    TextSpan(
                      text: 'mmHg',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF38435E),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateAverageBloodPressure() {
    List<Map<String, dynamic>> data = (json.decode(DummyData.bloodPressureData) as List<dynamic>)
        .cast<Map<String, dynamic>>();
    int totalSystolic = 0;
    int totalDiastolic = 0;
    for (var item in data) {
      totalSystolic += item['systolic'] as int;
      totalDiastolic += item['diastolic'] as int;
    }
    int avgSystolic = totalSystolic ~/ data.length;
    int avgDiastolic = totalDiastolic ~/ data.length;
    return '$avgSystolic/$avgDiastolic';
  }

  String _calculateDaysDifference() {
    List<Map<String, dynamic>> data = (json.decode(DummyData.bloodPressureData) as List<dynamic>)
        .cast<Map<String, dynamic>>();
    return (data.length - 1).toString();
  }

  String _calculatePressureDifference() {
    List<Map<String, dynamic>> data = (json.decode(DummyData.bloodPressureData) as List<dynamic>)
        .cast<Map<String, dynamic>>();
    int firstSystolic = data.first['systolic'] as int;
    int lastSystolic = data.last['systolic'] as int;
    int difference = (lastSystolic - firstSystolic).abs();
    return '$difference mmHg';
  }


  Widget _buildWarningCard(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: screenWidth - 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, 10),
            )
          ],
        ),
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 32),
        child: Center(
          child: Align(
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '오늘은 ${_calculateDaysDifference()} 일 전보다 ${_calculatePressureDifference()} 정도 높아요\n',
                    style: FontSystem.KR20B.copyWith(color: Colors.black),
                  ),
                  TextSpan(
                    text: '관리에 유의해 주세요!',
                    style: FontSystem.KR20B.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 4),
        Text(label, style: FontSystem.KR14R),
      ],
    );
  }

}