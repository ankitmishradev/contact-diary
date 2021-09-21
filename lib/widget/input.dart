import 'package:flutter/material.dart';
import './gradient.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    this.label,
    this.hintText,
    this.icon,
    this.onSaved,
    this.onFieldSubmitted,
    this.textInputType,
    this.textInputAction,
    this.focusNode,
    this.validator,
  }) : super(key: key);

  final String? label;
  final String? hintText;
  final IconData? icon;
  final void Function(String?)? onSaved;
  final void Function(String?)? onFieldSubmitted;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          icon: RadiantGradientMask(
            child: Icon(
              icon,
              size: 34,
              color: Colors.black,
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
          ),
          hintText: hintText,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 2,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 2,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 2,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 13.0,
          ),
          errorStyle: TextStyle(
            fontSize: 14,
          ),
        ),
        onSaved: onSaved,
        keyboardType: textInputType,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        focusNode: focusNode,
        validator: validator,
      ),
    );
  }
}
