import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../utils/validations.dart';
import '../models/person.dart';
import '../widget/new_page_header.dart';
import '../widget/input.dart';
import '../widget/divider.dart';
import '../widget/switch_input.dart';
import '../widget/dropdown_input.dart';

var uuid = Uuid();

class NewPage extends StatefulWidget {
  static String route = '/new';

  const NewPage({Key? key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  bool _inTouch = true;
  bool _isFav = false;
  int _group = 0;
  final _nameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final Person _newPersonData = Person(
    id: '',
    name: '',
    phone: 0,
    email: null,
    address: null,
    group: '',
    profileImage: null,
    inTouch: true,
    isFav: true,
  );

  void _onSavePressed(BuildContext context) {
    final persons = Provider.of<Persons>(context, listen: false);
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      //configure id
      _newPersonData.id = uuid.v4();
      //configure group
      _newPersonData.group = persons.groups[_group].groupName;
      //configure email
      _newPersonData.email == ""
          ? _newPersonData.email = null
          : _newPersonData.email;
      //configure address
      _newPersonData.address == ""
          ? _newPersonData.address = null
          : _newPersonData.address;
      //configure profileImage
      _newPersonData.profileImage == ""
          ? _newPersonData.profileImage = null
          : _newPersonData.profileImage;
      //configuring inTouch
      _newPersonData.inTouch = _inTouch;
      //configuring isFav
      _newPersonData.isFav = _isFav;

      //finally add the _newPersonData into the personsList
      persons.addPersonData(_newPersonData);
    }
  }

  //function to change inTouch swicth
  void _changeInTouchStatus() {
    setState(
      () {
        _inTouch = !_inTouch;
      },
    );
  }

  //function to change value of group
  void _changeGroup(String value, BuildContext context) {
    final persons = Provider.of<Persons>(context, listen: false);
    setState(
      () {
        _group = persons.groups.indexWhere((group) => group.groupName == value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final persons = Provider.of<Persons>(context);
    return Scaffold(
      appBar: buildAppBar(persons),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              NewPageHeader(),
              TextDivider(text: 'Primary Details'),
              buildNameInput(context),
              buildPhoneInput(context),
              buildEmailInput(context),
              buildAddressInput(context),
              TextDivider(text: 'Secondary Details'),
              buildInTouchSwitchInput(),
              buildgroupDropdownInput(context)
            ],
          ),
        ),
      ),
    );
  }

  Consumer<Persons> buildgroupDropdownInput(BuildContext context) {
    return Consumer<Persons>(
      builder: (_, persons, __) {
        return DropDownInput(
          icon: Icons.people,
          items: persons.groups,
          label: 'group',
          value: persons.groups[_group].groupName,
          onChanged: (value) {
            _changeGroup(value!, context);
          },
        );
      },
    );
  }

  SwitchInput buildInTouchSwitchInput() {
    return SwitchInput(
      icon: Icons.connect_without_contact_rounded,
      label: 'Is in touch?',
      value: _inTouch,
      onChanged: (_) => _changeInTouchStatus(),
    );
  }

  Input buildAddressInput(BuildContext context) {
    return Input(
      label: 'Address',
      icon: Icons.location_on,
      onSaved: (value) => _newPersonData.address = value!,
      validator: (value) => Validators.string(
        value,
        max: 160,
        min: 2,
      ),
      onFieldSubmitted: (_) => _onSavePressed(context),
    );
  }

  Input buildEmailInput(BuildContext context) {
    return Input(
      label: 'Email',
      icon: Icons.email,
      textInputAction: TextInputAction.next,
      validator: (value) => Validators.email(value),
      onSaved: (value) => _newPersonData.email = value!,
    );
  }

  Input buildPhoneInput(BuildContext context) {
    return Input(
      label: 'Phone',
      icon: Icons.phone_android,
      textInputType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      validator: (value) => Validators.intNum(
        value,
        isRequired: true,
        min: 4,
        max: 16,
      ),
      onSaved: (value) => _newPersonData.phone = int.parse(value!),
    );
  }

  Input buildNameInput(BuildContext context) {
    return Input(
      label: 'Name',
      icon: Icons.person,
      textInputAction: TextInputAction.next,
      focusNode: _nameFocusNode,
      onSaved: (values) => _newPersonData.name = values!,
      validator: (value) => Validators.string(
        value,
        isRequired: true,
        max: 16,
        min: 1,
      ),
    );
  }

  AppBar buildAppBar(Persons persons) {
    return AppBar(
      title: Text(
        'New Person',
      ),
      actions: [
        InkWell(
          onTap: () => _onSavePressed(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: Text(
              'Save',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
