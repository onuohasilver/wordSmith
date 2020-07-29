import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  /// Returns a tap-aware material rounded button
  /// that displays an Icon on a faded white background
  /// [icon] IconData is centered and with a default color of white.
  ///
  /// Sizing of the CardButton is achieved using a ratio of the MediaQuery height
  /// provided as the [height] argument. with the CardButton Occupying 5% of the device height
  /// ```dart
  /// CardButton(height:height,
  ///           onTap:()=>DoSomething(),
  ///           icon:Icons.forward)
  /// ```
  const CardButton({
    Key key,
    @required this.icon,
    @required this.height,
    @required this.onTap,
  }) : super(key: key);

  ///MediaQuery height
  final double height;

  ///Function to be executed on button tap
  final Function onTap;

  ///Icon to be displayed on the card body
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white.withOpacity(.2),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, color: Colors.white, size: height * .05),
            ),
            splashColor: Colors.white,
            onTap: onTap));
  }
}
