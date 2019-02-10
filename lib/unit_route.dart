import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:unit_converter/unit_scren.dart';


class UnitRoute extends StatelessWidget {
  final List<String> units;
  final int convert;

  String calculateConversion(String input, int from, int to) {
    double inputNum = double.parse(input);
    int ratio = to - from;
    if (ratio > 0) {
      return (inputNum * (convert * ratio)).toString();
    } else if (ratio < to) {
      return (inputNum / (convert * ratio.abs())).toString();
    } else {
      return input;
    }
  }

  const UnitRoute({
    Key key,
    @required this.units,
    @required this.convert,
  })  : assert(units != null),
        assert(convert != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return UnitScreen(
      units: units,
      convert: convert,
      callback: calculateConversion,
    );
  }
}

