import 'package:flutter/material.dart';

import './two_column_input.dart';

//ignore: must_be_immutable
class DropDownInput extends StatefulWidget {
  DropDownInput({
    Key? key,
    required this.icon,
    required this.items,
    required this.label,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  final IconData icon;
  final List items;
  final String label;
  String value;
  final void Function(String?)? onChanged;

  @override
  _DropDownInputState createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  @override
  Widget build(BuildContext context) {
    return TwoColumnInput(
      icon: widget.icon,
      label: widget.label,
      input: SizedBox(
        width: 150,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 16.0,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.black54,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.black54,
              ),
            ),
          ),
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          iconSize: 28.0,
          value: widget.value,
          items: widget.items.map<DropdownMenuItem<String>>(
            (dynamic value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          onChanged: widget.onChanged,
          icon: Icon(Icons.keyboard_arrow_down_rounded),
        ),
      ),
    );
  }
}
