import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/ui/pages/collection/controller.dart';

class TokenChart extends StatelessWidget {
  const TokenChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LineChart(
        mainData(),
      ),
    );
  }

  LineChartData mainData() {
    CollectionController controller = Get.find<CollectionController>();
    List<Color> gradientColors = [
      const Color(0xFFE785C0),
      const Color(0xFF9791EB),
    ];
    return LineChartData(
      gridData: FlGridData(
        drawHorizontalLine: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: controller.maxXLine.value.toDouble(),
      minY: 0,
      maxY: controller.chartView.value == 'growth'
          ? controller.maxTokensInGrowthView.value.toDouble() +
              controller.maxTokensInGrowthView.value.toDouble() / 10
          : controller.maxTokensInMonthlyView.value.toDouble() +
              controller.maxTokensInMonthlyView.value.toDouble() / 10,
      lineTouchData: LineTouchData(enabled: false),
      lineBarsData: [
        LineChartBarData(
          spots: controller.chartView.value == 'growth'
              ? controller.growthTokenSpots.value
              : controller.monthlyTokenSpots.value,
          isCurved: true,
          curveSmoothness: controller.chartView.value == 'growth' ? 0.2 : 0.2,
          preventCurveOverShooting: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          barWidth: controller.chartView.value == 'growth' ? 4 : 1,
          isStrokeCapRound:
              controller.chartView.value == 'growth' ? false : true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.9))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
