import 'package:flutter/material.dart';
import '../database/database.dart';
import '../models/group.dart';

export 'group.dart';

class Person with ChangeNotifier {
  String id;
  String name;
  int phone;
  String? email;
  bool isFav = false;
  bool inTouch = true;
  String group;
  String? address;
  String? profileImage;

  Person({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    this.profileImage,
    this.group = 'Family',
    this.inTouch = true,
    this.isFav = false,
  });

  void toggleFavoriteStatus() {
    isFav = !isFav;

    notifyListeners();
  }
}

class Persons with ChangeNotifier {
  Persons() {
    fetchPersonsData();
    fetchGroupsData();
  }

  //Methods to handle person related data starts here
  //Initiating persons list
  List<Person> list = [];

  //function to parse Person Object into a map
  Map<String, dynamic> toJSON(Person person) {
    return {
      'id': person.id,
      'name': person.name,
      'email': person.email,
      'phone': person.phone,
      'address': person.address,
      'group': person.group,
      'inTouch': person.inTouch ? 1 : 0,
      'isFav': person.isFav ? 1 : 0,
      'profileImage': person.profileImage,
    };
  }

  //function to parse Map into a Person Object
  Person fromJSON(Map<String, dynamic> person) {
    return Person(
      id: person['id'],
      address: person['address'],
      name: person['name'],
      phone: person['phone'],
      email: person['email'],
      isFav: person['isfav'] == 0 ? false : true,
      inTouch: person['inTouch'] == 0 ? false : true,
      profileImage: person['profileImage'],
      group: person['group'],
    );
  }

  //add
  //function to add person to the personList
  void addPersonData(Person person) async {
    await DiaryDB.instance.insert(toJSON(person), 'persons').then(
      (_) {
        list.add(person);
        notifyListeners();
      },
    );
  }

  //query
  //function to fetch whole personList
  void fetchPersonsData() async {
    final dataList = await DiaryDB.instance.queryAll('persons');

    list = dataList
        .map(
          (person) => fromJSON(person),
        )
        .toList();

    notifyListeners();
  }

  //delete
  //function to delete a person from personList by id
  void deletePersonDataById(String id) async {
    await DiaryDB.instance.delete(id, 'persons').then(
      (_) {
        list.removeWhere(
          (person) => person.id == id,
        );
        notifyListeners();
      },
    );
  }

  Person findById(String id) {
    return list.firstWhere((person) => person.id == id);
  }

  void changeFavStatus(id) {
    Person thisPerson = list.firstWhere((person) => person.id == id);

    thisPerson.toggleFavoriteStatus();

    notifyListeners();
  }

  //function to get list of all those persons who belongs to a specific group
  List<Person> findByGroup(String group) {
    return list.where((person) => person.group == group).toList();
  }

  //function to get list of all favorite marked persons
  List<Person> get favPersons {
    return list.where((person) => person.isFav).toList();
  }

  //Methods to handle group related data starts here
  //Initiating groups list
  List<Group> groups = [];

  //function to fetch groups list
  void fetchGroupsData() async {
    final dataList = await DiaryDB.instance.queryAll('groups');

    groups = dataList
        .map(
          (group) => Group(
            id: group['id'],
            groupName: group['group'],
          ),
        )
        .toList();
    notifyListeners();
  }

  //function to add a group data
  void addGroupData(Group group) async {
    Map<String, dynamic> newGroupData = {
      'id': group.id,
      'group': group.groupName,
    };
    await DiaryDB.instance.insert(newGroupData, 'groups').then(
      (_) {
        groups.add(group);
        notifyListeners();
      },
    );
  }

  //function to delete a group
  void deleteGroupById(String id) async {
    await DiaryDB.instance.delete(id, 'groups').then(
      (_) {
        groups.removeWhere(
          (group) => group.id == id,
        );
        notifyListeners();
      },
    );
  }
}
