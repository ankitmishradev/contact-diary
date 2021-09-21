import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/person.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    final person = Provider.of<Persons>(context).findById(id);

    final profileIcon = person.profileImage == null
        ? Icon(
            Icons.account_circle_rounded,
            size: 32,
          )
        : Image.network(
            person.profileImage.toString(),
            fit: BoxFit.contain,
          );

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Stack(children: <Widget>[
        profileIcon,
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 13,
            height: 13,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: person.inTouch ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
