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
  final inputTxt = TextEditingController();
  final displayTxt = TextEditingController();
  String defaultTextA;
  String defaultTextB;
  final List<String> units;
  final int convert;

  _CustomUnitScreen({
    @required this.units,
    @required this.convert,
  })  : assert(units != null),
        assert(convert != null);

  @override
  void dispose() {
    inputTxt.dispose();
    displayTxt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: inputTxt,
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
              // displayTxt.text = _value;
            });
          },
        ),
        RaisedButton(
            child: Icon(Icons.arrow_downward),
            onPressed: () {
              setState(() {
                displayTxt.text = inputTxt.text;
              });
            }),
        TextField(
          controller: displayTxt,
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
              // displayTxt.text = _value;
            });
          },
        ),
      ],
    ));
  }
}
