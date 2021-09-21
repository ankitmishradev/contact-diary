import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './view_page.dart';
import '../models/person.dart';
import './new_page.dart';
import '../widget/drawer_tile.dart';
import 'groups_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final persons = Provider.of<Persons>(context);

    List<Widget> tabs = buildTabList(persons);

    List<Widget> screens = buildTabScreens(persons);

    return Material(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: buildAppBar(tabs),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: screens,
            ),
          ),
        ),
        drawer: buildDrawer(),
        floatingActionButton: buildFloatingActionButton(),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed(NewPage.route);
      },
      child: Icon(
        Icons.add,
        size: 32,
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(),
            child: Text(
              'My Diary',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          DrawerTile(
            icon: Icons.home,
            text: 'Home',
          ),
          DrawerTile(
            onTap: () => Navigator.of(context).pushNamed(RelationsPage.route),
            icon: Icons.people_rounded,
            text: 'Relations',
          )
        ],
      ),
    );
  }

  SliverAppBar buildAppBar(List<Widget> tabs) {
    return SliverAppBar(
      title: const Text('Diary'),
      floating: true,
      pinned: true,
      snap: true,
      primary: true,
      forceElevated: true,
      bottom: TabBar(
        tabs: tabs,
      ),
    );
  }

  List<Widget> buildTabScreens(Persons persons) {
    final List<Widget> screens = [
      ViewPage(
        persons: persons.list,
      ),
      ViewPage(
        persons: persons.favPersons,
      ),
    ];
    return screens;
  }

  List<Widget> buildTabList(Persons persons) {
    final List<Widget> tabs = [
      Tab(text: 'All'),
      Tab(
        text: 'Favorites',
      ),
    ];
    return tabs;
  }
}
