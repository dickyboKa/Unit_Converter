import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:unit_converter/unit.dart';
import 'package:unit_converter/unit_screen.dart';

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
  /// This [Category]'s name.
  final String name;

  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  /// This [ConverterRoute] requires the name, color, and units to not be null.
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

    if (name == 'Digital Storage') {
      return UnitScreen(
        units: digitalStorage,
        convert: 1024,
      );
    } else {
      return ListView(
        children: unitWidgets,
      );
    }
  }
}
