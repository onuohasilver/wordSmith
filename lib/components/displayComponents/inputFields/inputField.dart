import 'package:flutter/material.dart';

import 'package:wordsmith/userProvider/userData.dart';



class InputText extends StatelessWidget {
  const InputText(
      {Key key,
      @required this.userData,
      @required this.hintText,
      @required this.onChanged,
      @required this.obscure,
      @required this.keyboardType,
      @required this.enforceLength})
      : super(key: key);

  final Data userData;
  final String hintText;
  final Function onChanged;
  final TextInputType keyboardType;
  final dynamic enforceLength;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35.0,8.0,35.0,8.0),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: keyboardType,
        maxLength: enforceLength,
        obscureText: obscure,
        decoration: InputDecoration(
          
            hintText: hintText,
            hintStyle: TextStyle(),
            filled: true,
            fillColor: Colors.white.withOpacity(.3),
            border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(15))),
        onChanged: onChanged,
      ),
    );
  }
}
