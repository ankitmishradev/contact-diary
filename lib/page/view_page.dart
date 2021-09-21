import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/person.dart';
import '../widget/tile.dart';
import '../database/database.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({
    Key? key,
    required this.persons,
  }) : super(key: key);

  final List<Person> persons;

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      return SafeArea(
        top: false,
        bottom: false,
        child: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Tile(
                        id: widget.persons[index].id,
                      );
                    }, childCount: widget.persons.length),
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
