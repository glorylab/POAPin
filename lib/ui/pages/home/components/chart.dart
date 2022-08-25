import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class TokenChart extends StatelessWidget {
  const TokenChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return c.chartView == 'heatmap'
          ? Container(
              width: 200,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.centerRight,
              child: HeatMap(
                size: 16,
                datasets: c.heatmapDataset,
                startDate: c.heatmapDataset.keys.first,
                colorMode: ColorMode.color,
                borderRadius: 2,
                margin: const EdgeInsets.all(1),
                showColorTip: false,
                showText: false,
                scrollable: false,
                fontSize: 0,
                defaultColor: Colors.green.withOpacity(0.03),
                colorsets: {
                  1: Colors.green.withOpacity(0.3),
                  2: Colors.green.withOpacity(0.4),
                  3: Colors.green.withOpacity(0.5),
                  4: Colors.green.withOpacity(0.6),
                  5: Colors.green.withOpacity(0.8),
                  10: Colors.green.withOpacity(0.9),
                  20: Colors.green.withOpacity(1),
                },
                onClick: (value) {
                  c.toggleChartView();
                },
              ),
            )
          : LineChart(
              mainData(c),
            );
    });
  }

  LineChartData mainData(HomeController c) {
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
      maxX: c.maxXLine.toDouble(),
      minY: 0,
      maxY: c.chartView == 'growth'
          ? c.maxTokensInGrowthView.toDouble() +
              c.maxTokensInGrowthView.toDouble() / 10
          : c.maxTokensInMonthlyView.toDouble() +
              c.maxTokensInMonthlyView.toDouble() / 10,
      lineTouchData: LineTouchData(enabled: false),
      lineBarsData: [
        LineChartBarData(
          spots: c.chartView == 'growth'
              ? c.growthTokenSpots
              : c.monthlyTokenSpots,
          isCurved: true,
          curveSmoothness: c.chartView == 'growth' ? 0.2 : 0.2,
          preventCurveOverShooting: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          barWidth: c.chartView == 'growth' ? 4 : 1,
          isStrokeCapRound: c.chartView == 'growth' ? false : true,
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
