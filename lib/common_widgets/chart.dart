import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas(context),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  '29.1',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                const Text('of 128GB')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas(BuildContext context) => [
      PieChartSectionData(
        color: Theme.of(context).accentColor,
        value: 25,
        showTitle: false,
        radius: 25,
      ),
      PieChartSectionData(
        color: const Color(0xFF26E5FF),
        value: 20,
        showTitle: false,
        radius: 22,
      ),
      PieChartSectionData(
        color: const Color(0xFFFFCF26),
        value: 10,
        showTitle: false,
        radius: 19,
      ),
      PieChartSectionData(
        color: const Color(0xFFEE2727),
        value: 15,
        showTitle: false,
        radius: 16,
      ),
      PieChartSectionData(
        color: Theme.of(context).accentColor.withOpacity(0.1),
        value: 25,
        showTitle: false,
        radius: 13,
      ),
    ];
