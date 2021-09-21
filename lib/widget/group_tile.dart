import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/person.dart';
import '../widget/icon_button.dart';
import '../widget/person_count.dart';

class RelationTile extends StatelessWidget {
  const RelationTile({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    final persons = Provider.of<Persons>(context);
    final String group =
        persons.groups.firstWhere((curGroup) => curGroup.id == id).id;

    return Container(
      clipBehavior: Clip.hardEdge,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: buildGroupTitle(group),
                        ),
                        Expanded(
                          child: buildPersonCount(group),
                        )
                      ],
                    ),
                  ),
                ),
                buildGroupActions(persons),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildPersonCount(String group) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.maxFinite,
      child: PersonCount(group: group),
    );
  }

  Row buildGroupActions(Persons persons) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconBtn(
          icon: Icon(Icons.add),
          onTap: () {},
        ),
        IconBtn(
          icon: Icon(Icons.delete),
          onTap: () {
            persons.deleteGroupById(id);
          },
        ),
      ],
    );
  }

  Container buildGroupTitle(String group) {
    return Container(
      width: double.maxFinite,
      alignment: Alignment.centerLeft,
      child: Text(
        group,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
