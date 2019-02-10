import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class UnitScreen extends StatefulWidget {
  final List<String> units;
  final int convert;
  final Function(String, int, int) callback;

  UnitScreen({
    Key key,
    @required this.units,
    @required this.convert,
    this.callback,
  })  : assert(units != null),
        assert(convert != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomUnitScreen(
        units: units, convert: convert, callback: callback);
  }
}

class _CustomUnitScreen extends State<UnitScreen> {
  final inputController = TextEditingController();
  final diplsayController = TextEditingController();
  Function(String, int, int) callback;

  String defaultTextA;
  String defaultTextB;

  int from = 0;
  int to = 0;

  final List<String> units;
  final int convert;

  _CustomUnitScreen({
    @required this.units,
    @required this.convert,
    this.callback,
  })  : assert(units != null),
        assert(convert != null);

  @override
  void initState() {
    super.initState();

    inputController.addListener(_responseToChange);
  }

  _responseToChange() {
    setState(() {
      String output = callback(inputController.text, from, to);
      diplsayController.text = output;
    });
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
            EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                border: Border.all(color: Colors.black38)),
            height: 65,
            padding: EdgeInsets.all(10.0),
            child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
              isExpanded: true,
              value:
                  textA ? defaultTextA ?? units[0] : defaultTextB ?? units[0],
              items: units.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (String _value) {
                setState(() {
                  if (textA)
                    defaultTextA = _value;
                  else
                    defaultTextB = _value;

                  from = units.indexOf(_value) + 1;
                  if (inputController.text.isNotEmpty) {
                    String output = callback(inputController.text, from, to);
                    diplsayController.text = output;
                  }
                });
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
      )
    );
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
