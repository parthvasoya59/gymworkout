import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../Constant/colors.dart';

class Progressbar extends StatelessWidget {
  const Progressbar({Key? key, required this.valueIn}) : super(key: key);

  final double valueIn;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      width: w * 0.40,
      child: SfLinearGauge(
        showTicks: false,
        showLabels: false,
        animateAxis: true,
        axisTrackStyle: LinearAxisTrackStyle(
            thickness: 3,
            edgeStyle: LinearEdgeStyle.bothCurve,
            color: cGrey
        ),
        barPointers: <LinearBarPointer>[
          LinearBarPointer(
              value: valueIn,
              thickness: 3,
              edgeStyle: LinearEdgeStyle.bothCurve,
              color: Color(0xFFFFFFFF)),
        ],
      ),
    );
  }
}
