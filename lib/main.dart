import 'package:flutter/material.dart';

// More details at http://dart-lang.github.io/linter/lints/avoid_relative_lib_imports.html
import 'package:unit_converter/category_route.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      home: CategoryRoute(),
    );
  }
}