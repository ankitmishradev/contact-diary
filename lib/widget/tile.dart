import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/person.dart';
import './modal.dart';
import './icon_button.dart';
import './profile_icon.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    final double tileHeight = 60;
    final person = Provider.of<Persons>(context).findById(id);
    return Container(
      clipBehavior: Clip.hardEdge,
      height: tileHeight,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: -2,
            offset: Offset(1, 1),
            color: Colors.black38,
          ),
        ],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Material(
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => PopupDialog(person.id),
            );
          },
          child: Row(
            children: [
              buildLeading(tileHeight, context, person),
              buildContent(tileHeight, context, person),
              buildTrailing(tileHeight, context, person),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTrailing(double tileHeight, BuildContext context, Person person) {
    final persons = Provider.of<Persons>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          IconBtn(
            onTap: () => persons.deletePersonDataById(id),
            icon: Icon(
              Icons.delete,
            ),
          ),
          IconBtn(
            onTap: () => persons.changeFavStatus(id),
            icon: Icon(
              person.isFav
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildContent(
      double tileHeight, BuildContext context, Person person) {
    return Expanded(
      child: Container(
        height: tileHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextContainer(Text(
              person.name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            )),
            buildTextContainer(Text(
              '+91 ${person.phone}',
              style: TextStyle(
                color: Colors.black45,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Container buildTextContainer(dynamic child) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 3.0,
        horizontal: 8.0,
      ),
      child: child,
    );
  }

  Widget buildLeading(double tileHeight, BuildContext context, Person person) {
    return ProfileIcon(id: id);
  }
}
