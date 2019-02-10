import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class UnitScreen extends StatelessWidget {
  final List<String> units;
  final int convert;

  const UnitScreen({
    Key key,
    @required this.units,
    @required this.convert,
  })  : assert(units != null),
        assert(convert != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return UnitScreenState(
      units: units,
      convert: convert,
    );
  }
}

class UnitScreenState extends StatefulWidget {
  final List<String> units;
  final int convert;

  UnitScreenState({
    Key key,
    @required this.units,
    @required this.convert,
  })  : assert(units != null),
        assert(convert != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomUnitScreen(units: units, convert: convert);
  }
}

class _CustomUnitScreen extends State<UnitScreenState> {
  final inputTxtController = TextEditingController();
  final displayTxtController = TextEditingController();
  String defaultTextA;
  String defaultTextB;

  int from = 0;
  int to = 0;

  final List<String> units;
  final int convert;

  _CustomUnitScreen({
    @required this.units,
    @required this.convert,
  })  : assert(units != null),
        assert(convert != null);

  @override
  void initState() {
    super.initState();

    inputTxtController.addListener(_responseToChange);
  }

  String __calculateConversion(String input) {
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

  _responseToChange() {
    setState(() {
      String output = __calculateConversion(inputTxtController.text);
      displayTxtController.text = output;
    });
  }

  @override
  void dispose() {
    inputTxtController.dispose();
    displayTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: inputTxtController,
          keyboardType: TextInputType.number,
        ),
        DropdownButton<String>(
          value: defaultTextA ?? units[0],
          items: units.map((String location) {
            return DropdownMenuItem<String>(
              value: location,
              child: Text(location),
            );
          }).toList(),
          onChanged: (String _value) {
            setState(() {
              defaultTextA = _value;
              from = units.indexOf(_value) + 1;
              if (inputTxtController.text.isNotEmpty) {
                String output = __calculateConversion(inputTxtController.text);
                displayTxtController.text = output;
              }
            });
          },
        ),
        RaisedButton(
            child: Icon(Icons.arrow_downward),
            onPressed: () {
              setState(() {
                displayTxtController.text = inputTxtController.text;
              });
            }),
        TextField(
          controller: displayTxtController,
        ),
        DropdownButton<String>(
          value: defaultTextB ?? units[0],
          items: units.map((String location) {
            return DropdownMenuItem<String>(
              value: location,
              child: Text(location),
            );
          }).toList(),
          onChanged: (String _value) {
            setState(() {
              defaultTextB = _value;
              to = units.indexOf(_value) + 1;
              if (inputTxtController.text.isNotEmpty) {
                String output = __calculateConversion(inputTxtController.text);
                displayTxtController.text = output;
              }
            });
          },
        ),
      ],
    ));
  }
}
