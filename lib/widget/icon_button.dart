import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final void Function() onTap;
  final double? width;
  final double? height;
  final Widget icon;

  const IconBtn({
    Key? key,
    this.width = null,
    this.height = null,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        radius: 50.0,
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: icon,
        ),
      ),
    );
  }
}
