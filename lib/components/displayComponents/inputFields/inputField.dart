import 'package:flutter/material.dart';

import 'package:wordsmith/userProvider/userData.dart';



class InputText extends StatelessWidget {
  const InputText(
      {Key key,
      @required this.userData,
      @required this.hintText,
      this.onChanged,
      @required this.keyboardType,
      @required this.enforceLength})
      : super(key: key);

  final Data userData;
  final String hintText;
  final Function onChanged;
  final TextInputType keyboardType;
  final dynamic enforceLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      keyboardType: keyboardType,
      maxLength: enforceLength,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(),
          filled: true,
          fillColor: Colors.lightBlueAccent.withOpacity(.3),
          border: OutlineInputBorder(borderSide: BorderSide.none)),
      onChanged: onChanged,
    );
  }
}
