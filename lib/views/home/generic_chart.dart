import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GenericChart extends StatelessWidget {
  final List<List<FlSpot>> dataSets;
  final List<Color> colors;
  final String xAxisTitle;
  final String yAxisTitle;
  final double minY;
  final double maxY;

  GenericChart({
    Key? key,
    required this.dataSets,
    required this.colors,
    this.xAxisTitle = '',
    this.yAxisTitle = '',
    required this.minY,
    required this.maxY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
              axisNameWidget: Text(xAxisTitle),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
              axisNameWidget: Text(yAxisTitle),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: dataSets.isNotEmpty ? dataSets[0].length.toDouble() - 1 : 0,
          minY: minY,
          maxY: maxY,
          lineBarsData: List.generate(
            dataSets.length,
                (index) => LineChartBarData(
              spots: dataSets[index],
              isCurved: true,
              color: colors[index],
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ),
        ),
      ),
    );
  }
}