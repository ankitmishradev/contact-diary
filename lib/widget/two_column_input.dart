import 'package:flutter/material.dart';

import './gradient.dart';

class TwoColumnInput extends StatelessWidget {
  const TwoColumnInput({
    Key? key,
    required this.label,
    required this.input,
    required this.icon,
  }) : super(key: key);

  final String label;
  final Widget input;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: 16.0,
                ),
                child: RadiantGradientMask(
                  child: Icon(
                    icon,
                    size: 34,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          input,
        ],
      ),
    );
  }
}
