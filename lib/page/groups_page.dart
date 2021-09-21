import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/group_tile.dart';
import '../models/person.dart';
import '../widget/tile.dart';
import '../widget/icon_button.dart';

class RelationsPage extends StatelessWidget {
  static final route = '/relations';

  const RelationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final persons = Provider.of<Persons>(context);
    final relations = persons.groups;

    return Scaffold(
      appBar: AppBar(
        title: Text('Relations'),
        actions: [
          IconBtn(
            icon: Icon(
              Icons.add,
            ),
            onTap: () {
              persons.addGroupData(
                Group(
                  id: 'abcwtyrwdees',
                  groupName: 'Friends',
                ),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (_, i) => RelationTile(
          id: relations[i].id,
        ),
        itemCount: relations.length,
      ),
    );
  }
}
