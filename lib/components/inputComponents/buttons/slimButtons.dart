import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsmith/core/sound.dart';
import 'package:wordsmith/core/utilities/constants.dart';

class SlimButton extends StatelessWidget {
  ///returns a Material Button that takes a
  ///by default a [Text] as a child but can be
  ///instructed to take any kind of widget as a child
  ///when the [useWidget] argument is set as true
  ///this becomes useful if a loading indicator is desired
  ///to be shown in the place of the text when a
  ///pre-specified condition has been met
  ///of course a setState is called outside the [SlimButton]
  ///scope to enable it rebuild it appearance
  SlimButton({this.onTap, this.label, this.color, this.textColor, this.widget});

  ///label text of the custom [Material] button
  final String label;

  /// [Function] to be performed when a tap gesture is detected
  final Function onTap;

  /// basic color of the  button area defaults to material [Colors.white10]
  final Color color;

  ///Color of the text defaults to material [Colors.black]
  final Color textColor;

  /// Secondary widget that is only displayed when the useWiget
  ///  Value is set to true
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(34, 10, 34, 10),
            child: widget ??
                Text(
                  label,
                  style: TextStyle(
                      color: textColor ?? Colors.black,
                      fontWeight: FontWeight.w600),
                ),
          ),
        ),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color ?? Colors.white10);
  }
}

class SignUp extends StatelessWidget {
  ///A relatively tiny button that tightly hugs its text child
  ///Used in minor registration navigation
  ///accepts [String] routeName as registered on the [main.dart] file
  ///and a label
  const SignUp({Key key, @required this.routeName, @required this.label})
      : super(key: key);

  ///routeName as registered on the main dart file
  final String routeName;

  ///label text on the button
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white.withOpacity(.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.pushReplacementNamed(context, routeName);
          // buttonSound();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.white,
                shadows: kTextShadow,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }
}
