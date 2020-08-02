import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefinitionPopUp extends StatelessWidget {
  final double width;
  final double height;
  final String definition;
  final String word;

  const DefinitionPopUp({
    Key key,
    @required this.width,
    @required this.height,
    @required this.definition,
    @required this.word,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          height: height * .3,
          width: width * .7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  word,
                  style: GoogleFonts.poppins(
                      fontSize: width * .055, fontWeight: FontWeight.w800),
                ),
                Text(
                  
                  definition,textAlign:TextAlign.justify,
                  style: GoogleFonts.poppins(fontSize: width * .035),
                ),
              ],
            ),
          )),
    );
  }
}
