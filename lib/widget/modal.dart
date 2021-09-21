import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/person.dart';
import './icon_button.dart';
import './profile_icon.dart';

class PopupDialog extends StatelessWidget {
  const PopupDialog(
    this.id, {
    Key? key,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    final persons = Provider.of<Persons>(context);
    final person = persons.findById(id);
    return new AlertDialog(
      title: buildModalTitle(person, persons),
      content: buildModalContent(person),
      actions: buildModalActions(context),
      titlePadding: EdgeInsets.all(10.0),
      contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
    );
  }

  Container buildModalTitle(Person person, Persons persons) {
    return Container(
      height: 50,
      child: Row(
        children: [
          ProfileIcon(id: person.id),
          Expanded(
            child: Text(
              person.name,
            ),
          ),
          IconBtn(
            onTap: () => persons.changeFavStatus(id),
            icon: Icon(
              person.isFav
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildModalActions(BuildContext context) {
    return <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Ok'),
      ),
    ];
  }

  Container buildModalContent(Person person) {
    return Container(
      height: 200,
      width: double.maxFinite,
      child: Column(
        children: [
          ModalTile(
            title: person.address,
            icon: Icons.map_rounded,
          ),
          ModalTile(
            title: person.phone,
            icon: Icons.call,
          ),
          ModalTile(
            title: person.email,
            icon: Icons.email,
          ),
          ModalTile(
            title: person.group,
            icon: Icons.people_rounded,
          ),
        ],
      ),
    );
  }
}

class ModalTile extends StatelessWidget {
  const ModalTile({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final dynamic title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
        ),
        title: Text(
          title.toString(),
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
