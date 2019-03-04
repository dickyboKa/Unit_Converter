import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:unit_converter/unit.dart';

class UnitScreen extends StatefulWidget {
  final List<Unit> dropDownItems;

  UnitScreen({
    final Key key,
    @required this.dropDownItems,
  })  : assert(dropDownItems != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomUnitScreen(dropDownItems: dropDownItems);
  }
}

class _CustomUnitScreen extends State<UnitScreen> {
  final inputController = TextEditingController();
  final diplsayController = TextEditingController();
  bool _showValidationError = false;
  String defaultTextA;
  String defaultTextB;

  double from;
  double to;

  final List<Unit> dropDownItems;

  _CustomUnitScreen({
    @required this.dropDownItems,
  }) : assert(dropDownItems != null) {
    from = dropDownItems.first.conversion;
    to = dropDownItems.first.conversion;
  }

  @override
  void initState() {
    super.initState();

    inputController.addListener(_responseToChange);
  }

  String _calculateConversion(double input) {
    double conversion = input * (to / from);
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  __responeToChangeDrop(String _value, bool textA) {
    Unit changeUnit;
    dropDownItems.forEach((Unit unit) {
      if (unit.name == _value) changeUnit = unit;
    });

    setState(() {
      if (textA) {
        defaultTextA = _value;
        from = changeUnit.conversion;
      } else {
        defaultTextB = _value;
        to = changeUnit.conversion;
      }
      if (inputController.text.isNotEmpty) {
        // Even though we are using the numerical keyboard, we still have to check
        // for non-numerical input such as '5..0' or '6 -3'
        try {
          final inputDouble = double.parse(_value);
          _showValidationError = false;
          String output = _calculateConversion(inputDouble);
          diplsayController.text = output;
        diplsayController.text = output;
        } on Exception catch (e) {
          print('Error: $e');
          _showValidationError = true;
        }
      }
    });
  }

  _responseToChange() {
    if (inputController.text.isNotEmpty) {
      setState(() {
        try {
          final inputDouble = double.parse(inputController.text);
          _showValidationError = false;
          String output = _calculateConversion(inputDouble);
          diplsayController.text = output;
        diplsayController.text = output;
        } on Exception catch (e) {
          print('Error: $e');
          _showValidationError = true;
        }
      });
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    diplsayController.dispose();
    super.dispose();
  }

  Widget textView(bool enable, TextEditingController controller, String label) {
    return Container(
      padding:
          EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          errorText: _showValidationError ? 'Invalid number entered' : null,
        ),
        enabled: enable,
        controller: controller,
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget dropDownView(bool textA) {
    return Container(
        padding:
            EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                border: Border.all(color: Colors.black38)),
            height: 65,
            padding: EdgeInsets.all(10.0),
            child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
              isExpanded: true,
              value: textA
                  ? defaultTextA ?? dropDownItems.first.name
                  : defaultTextB ?? dropDownItems.first.name,
              items: dropDownItems.map((Unit unit) {
                return DropdownMenuItem<String>(
                  value: unit.name,
                  child: Text(unit.name),
                );
              }).toList(),
              onChanged: (String _value) {
                __responeToChangeDrop(_value, textA);
              },
            ))));
  }

  Widget iconArrow() {
    return Container(
        height: 70,
        padding: EdgeInsets.only(top: 10.0, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: Icon(Icons.arrow_upward)),
            Icon(Icons.arrow_downward),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textView(true, inputController, "Input"),
            dropDownView(true),
            iconArrow(),
            textView(false, diplsayController, "Output"),
            dropDownView(false),
          ],
        ));
  }
}
