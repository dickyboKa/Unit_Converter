import 'dart:async';
import 'dart:convert' as json;

import 'package:flutter/material.dart';

import 'package:unit_converter/category_screen.dart';
import 'package:unit_converter/unit.dart';

final _categoryColor = Colors.white;
final _appBarColor = Colors.teal;

class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  @override
  _CategoryRouteState createState() => _CategoryRouteState();
}
class _CategoryRouteState extends State<CategoryRoute> {

  final _categories = <Category>[];
  static const _iconLocation = <IconData>[
    Icons.sd_card,
    Icons.straighten,
    Icons.dashboard,
    Icons.battery_full,
    Icons.call_to_action,
    Icons.access_time,
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
    int iTab = i * 4;
    return Container(
        padding: EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            categories[iTab],
            categories[iTab + 1],
            categories[iTab + 2],
            categories[iTab + 3],
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

  Widget _buildCategoryWidgetsSimple(List<Widget> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return categories[index];
      },
    );
  }

  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(10, (int i) {
      i += 1;
      return Unit(
        name: '$categoryName Unit $i',
        conversion: i.toDouble(),
      );
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    // We have static unit conversions located in our
    // assets/data/regular_units.json
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
    }
  }

  Future<void> _retrieveLocalCategories() async {
    final jsonStr = await DefaultAssetBundle.of(context).loadString('assets/data/regular_units.json');
    final data = json.JsonDecoder().convert( jsonStr);
    if (data is! Map) {
      throw ('Data retrieved from API is not a Map');
    }
    var categoryIndex = 0;
    data.keys.forEach((key) {
      final List<Unit> units =
          data[key].map<Unit>((dynamic data) => Unit.fromJson(data)).toList();
      print(units.length);
      var category = Category(
        name: key,
        units: units,
        color: _baseColors[categoryIndex],
        iconLocation: Icons.cake,
      );

      setState(() {
        _categories.add(category);
      });
      ++categoryIndex;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (_categories.isEmpty) {
      return Center(
        child: Container(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }

    final listView = Container(
      color: _categoryColor,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryWidgetsSimple(_categories),
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
