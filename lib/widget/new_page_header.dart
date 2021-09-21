import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './icon_button.dart';

class NewPageHeader extends StatefulWidget {
  const NewPageHeader({Key? key}) : super(key: key);

  @override
  _NewPageHeaderState createState() => _NewPageHeaderState();
}

class _NewPageHeaderState extends State<NewPageHeader> {
  File? _image;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(bottom: 8.0),
      alignment: Alignment.center,
      child: Stack(
        children: [
          _image == null
              ? Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                  size: 128,
                )
              : Image.file(_image!),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 3.0,
                  )
                ],
              ),
              child: IconBtn(
                onTap: getImage,
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
