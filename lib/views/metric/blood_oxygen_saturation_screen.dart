import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/font_system.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import'../../models/home/dummy_data.dart';

class BloodOxygenSaturationScreen extends StatelessWidget {
  const BloodOxygenSaturationScreen({Key? key}) : super(key: key);

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
                child: _buildAverageBOSCard(context),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: _buildBOSCard(context),
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
                '혈중 산소 포화도',
                style: FontSystem.KR22B.copyWith(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAverageBOSCard(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> data = (json.decode(DummyData.oxygenSaturationData) as List<dynamic>)
        .cast<Map<String, dynamic>>();

    double average = data.map((item) => item['value'] as double).reduce((a, b) => a + b) / data.length;

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
            '한달 간 평균 포화도',
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
                '${(average * 100).toStringAsFixed(1)}%',
                style: FontSystem.KR35B.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBOSCard(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> data = (json.decode(DummyData.oxygenSaturationData) as List<dynamic>)
        .cast<Map<String, dynamic>>();

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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Image.asset('assets/images/bloodoxygensaturation.png', width: 25, height: 25),
              SizedBox(width: 6,),
              Text('한달 간 포화도 측정 그래프', style: FontSystem.KR16B.copyWith(color: Colors.black)),
            ],
          ),
          SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1.70,
            child: LineChart(
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
                minY: 0.9,
                maxY: 1.0,
                lineBarsData: [
                  LineChartBarData(
                    spots: data.asMap().entries.map((entry) =>
                        FlSpot(entry.key.toDouble(), entry.value['value'])
                    ).toList(),
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
          ),
          SizedBox(height: 16),
          Center(
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFFA295FF), Color(0xFF1C336E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                '${(data.last['value'] * 100).toStringAsFixed(1)}%',
                style: FontSystem.KR42B.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> data = (json.decode(DummyData.oxygenSaturationData) as List<dynamic>)
        .cast<Map<String, dynamic>>();

    double lastValue = data.last['value'];
    double firstValue = data.first['value'];
    int daysDifference = data.length - 1;
    String difference = ((lastValue - firstValue) * 100).abs().toStringAsFixed(1);

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
                    text: '오늘은 $daysDifference일 전보다 $difference% 정도 ${lastValue > firstValue ? '높아요' : '낮아요'}\n',
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
}
