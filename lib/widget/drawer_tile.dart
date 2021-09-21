import 'package:flutter/material.dart';

import './gradient.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {Key? key, required this.icon, required this.text, this.onTap})
      : super(key: key);

  final IconData icon;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          height: 50,
          width: double.maxFinite,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: RadiantGradientMask(
                  child: Icon(
                    icon,
                    size: 30,
                  ),
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
