import 'package:flutter/material.dart';

import 'package:unit_converter/category_screen.dart';
//import 'package:task_04_navigation/unit.dart';

final _categoryColor = Colors.white;
final _appBarColor = Colors.teal;

class CategoryRoute extends StatelessWidget {
  const CategoryRoute();

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _iconLocation = <IconData>[
    Icons.straighten,
    Icons.dashboard,
    Icons.battery_full,
    Icons.call_to_action,
    Icons.access_time,
    Icons.sd_card,
    Icons.flash_on,
    Icons.attach_money,
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  Widget _buildCategoryRowWidgets(List<Widget> categories, int i) {
    int index = i % 3;
    return Container(
        padding: EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            categories[i],
            categories[i + 1],
            categories[i + 2],
          ],
        ));
  }

  Widget _buildCategoryWidgets(List<Widget> categories) {
    return ListView.builder(
      itemCount: (categories.length / 3).toInt(),
      itemBuilder: (BuildContext context, int index) {
        return _buildCategoryRowWidgets(categories, index);
      },
    );
  }

  /// Returns a list of mock [Unit]s.
  //List<Unit> _retrieveUnitList(String categoryName) {
  //  return List.generate(10, (int i) {
  //    i += 1;
  //    return Unit(
  //      name: '$categoryName Unit $i',
  //      conversion: i.toDouble(),
  //    );
  //  });
  //}

  @override
  Widget build(BuildContext context) {
    final categories = <Category>[];

    for (var i = 0; i < _categoryNames.length; i++) {
      categories.add(Category(
        name: _categoryNames[i],
        color: _baseColors[i],
        iconLocation: _iconLocation[i],
        //units: _retrieveUnitList(_categoryNames[i]),
      ));
    }
    print((categories.length / 3).round());
    final listView = Container(
      color: _categoryColor,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryWidgets(categories),
    );

    final appBar = AppBar(
      elevation: 0.0,
      title: Text(
        'Unit Converter',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: _appBarColor,
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}
