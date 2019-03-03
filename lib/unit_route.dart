import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:unit_converter/unit.dart';
import 'package:unit_converter/unit_scren.dart';


class UnitRoute extends StatelessWidget {
  final List<Unit> units;

  UnitRoute({
    Key key,
    @required this.units,
  })  : assert(units != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return UnitScreen(
      dropDownItems: units,
    );
  }
}

