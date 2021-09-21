import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({
    Key? key,
    this.height,
    this.color,
    required this.text,
  }) : super(key: key);

  final double? height;
  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      height: height == null ? 20.0 : height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 0.5,
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              alignment: Alignment.center,
              height: height == null ? 20.0 : height,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              color: Colors.white,
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
