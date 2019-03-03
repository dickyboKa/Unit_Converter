import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:unit_converter/unit.dart';
import 'package:unit_converter/unit_route.dart';

class ConverterRoute extends StatelessWidget {

  static const digitalStorage = <String>[
    'Byte',
    'Kilobyte(KB)',
    'Megabyte(MB)',
    'Gigabyte(GB)',
    'Terabyte(TB)',
    'Petabyte(PB)',
    'Exabyte(EB)',
  ];
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
    // Here is just a placeholder for a list of mock units
    final unitWidgets = units.map((Unit unit) {
      return Container(
        color: color,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              unit.name,
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              'Conversion: ${unit.conversion}',
              style: Theme.of(context).textTheme.subhead,
            ),
          ],
        ),
      );
    }).toList();

    return UnitRoute(units: units);
  }
}
