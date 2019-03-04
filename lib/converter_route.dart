import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:unit_converter/unit.dart';
import 'package:unit_converter/unit_route.dart';

class ConverterRoute extends StatelessWidget {

 final String name;
 final Color color;
 final List<Unit> units;

  const ConverterRoute({
    @required this.name,
    @required this.color,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(units != null);

  @override
  Widget build(BuildContext context) {
    return UnitRoute(units: units);
  }
}
