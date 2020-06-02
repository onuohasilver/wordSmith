import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/constants.dart';

class SlimButton extends StatelessWidget {
  SlimButton(
      {this.onTap,
      this.label,
      this.color,
      this.textColor,
      @required this.useWidget,
      this.widget});
  final String label;
  final Function onTap;
  final Color color;
  final Color textColor;
  final bool useWidget;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(34, 10, 34, 10),
            child: useWidget
                ? widget
                : Text(
                    label,
                    style: TextStyle(
                        color: this.textColor, fontWeight: FontWeight.w600),
                  ),
          ),
        ),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color);
  }
}




class SignUp extends StatelessWidget {
  const SignUp({Key key, @required this.routeName,@required this.label}) : super(key: key);
  final String routeName;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white.withOpacity(.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => Navigator.pushNamed(context,routeName),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(
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
