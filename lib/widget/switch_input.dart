import 'package:flutter/material.dart';

import './two_column_input.dart';

//ignore: must_be_immutable
class SwitchInput extends StatefulWidget {
  SwitchInput({
    Key? key,
    required this.label,
    this.value = false,
    required this.icon,
    this.onChanged,
  }) : super(key: key);

  final String label;
  bool value;
  final IconData icon;
  final void Function(bool)? onChanged;
  @override
  _SwitchInputState createState() => _SwitchInputState();
}

class _SwitchInputState extends State<SwitchInput> {
  @override
  Widget build(BuildContext context) {
    return TwoColumnInput(
      icon: widget.icon,
      label: widget.label,
      input: Switch(
        value: widget.value,
        onChanged: widget.onChanged,
      ),
    );
  }
}
