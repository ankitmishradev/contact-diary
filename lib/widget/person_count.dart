import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/person.dart';
import './icon_button.dart';

class PersonCount extends StatelessWidget {
  const PersonCount({
    Key? key,
    required this.group,
  }) : super(key: key);

  final String group;

  @override
  Widget build(BuildContext context) {
    final persons = Provider.of<Persons>(context);

    return _buildPersonCount(persons, group);
  }

  Widget _buildPersonChimp(Person person) {
    final profileIcon = person.profileImage == null
        ? Text(
            person.name.characters.elementAt(0).toUpperCase(),
          )
        : Icon(
            Icons.account_circle_rounded,
            size: 32,
          );
    return profileIcon;
  }

  Widget _counterContainer(Widget child) {
    return Container(
      height: 30,
      width: 30,
      color: Colors.white,
      alignment: Alignment.center,
      child: Container(
        height: 20,
        width: 20,
        color: Colors.grey[300],
        child: child,
      ),
    );
  }

  Widget _buildPersonCount(Persons persons, String group) {
    final int personCount = persons.findByGroup(group).length;

    Widget getFirstChimp() {
      final person = persons.findByGroup(group)[0];
      final personImg = _buildPersonChimp(person);
      return _counterContainer(personImg);
    }

    Widget getSecondChimp() {
      final person = persons.findByGroup(group)[1];
      final personImg = _buildPersonChimp(person);
      return _counterContainer(personImg);
    }

    Widget getThirdChimp() {
      final person = persons.findByGroup(group)[2];
      final personImg = _buildPersonChimp(person);
      return _counterContainer(personImg);
    }

    Widget getFourthChimp() {
      if (personCount < 10 && personCount > 3) {
        return _counterContainer(Text('$personCount'));
      } else {
        return _counterContainer(Text('9+'));
      }
    }

    List<Widget> _buildStack() {
      if (personCount > 0 && personCount < 2) {
        return [
          Positioned(
            left: 0,
            child: getFirstChimp(),
          ),
        ];
      }
      if (personCount > 0 && personCount < 3) {
        return [
          Positioned(
            left: 0,
            child: getFirstChimp(),
          ),
          Positioned(
            left: 25,
            child: getSecondChimp(),
          ),
        ];
      }
      if (personCount > 0 && personCount < 4) {
        return [
          Positioned(
            left: 0,
            child: getFirstChimp(),
          ),
          Positioned(
            left: 25,
            child: getSecondChimp(),
          ),
          Positioned(
            left: 50,
            child: getThirdChimp(),
          ),
        ];
      }
      return [
        Positioned(
          left: 0,
          child: getFirstChimp(),
        ),
        Positioned(
          left: 25,
          child: getSecondChimp(),
        ),
        Positioned(
          left: 50,
          child: getThirdChimp(),
        ),
        Positioned(
          left: 75,
          child: getFourthChimp(),
        ),
      ];
    }

    return personCount != 0
        ? Stack(
            children: _buildStack(),
          )
        : Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.warning_rounded,
                  size: 19,
                  color: Colors.orange,
                ),
              ),
              Text(
                'This group is empty.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
  }
}
