import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';


class InputText extends StatelessWidget {
  ///Creates the common text field used app-wide
  ///[InputText] can receive an [Animation] argument which details
  ///behaviour of the [InputText] on the initiation of screen.
  ///defaults to a white [TextField] with minimal opacity
  ///```dart
  ///InputText(
  ///  userData:data   ,  onChanged:(text)=>data.setValue(text),
  ///  hintText:'Enter Text'   ,   obscure:false,
  ///  keyboardType:TextInputType.emailAddress,
  ///  enforceLength:true, animation:animation, width:width
  ///  )
  ///```
  const InputText({
    Key key,
    @required this.userData,
    @required this.hintText,
    @required this.onChanged,
    @required this.obscure,
    @required this.keyboardType,
    @required this.enforceLength,
    @required this.animation,
    @required this.width,
  }) : super(key: key);

  ///Provider [Data] that handles user centric related app details
  final Data userData;

  ///Text[String] to be displayed in the TextField to prompt User Input
  final String hintText;

  /// Changes in the content of the textField prompts this [Function]
  final Function onChanged;
  final TextInputType keyboardType;
  final dynamic enforceLength;
  final bool obscure;
  final Animation animation;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(animation.value * width, 0, 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(35.0, 8.0, 35.0, 8.0),
        child: TextField(
          style: GoogleFonts.poppins(),
          textAlign: TextAlign.center,
          keyboardType: keyboardType,
          maxLength: enforceLength,
          obscureText: obscure,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(),
              filled: true,
              fillColor: Colors.white.withOpacity(.3),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15))),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
