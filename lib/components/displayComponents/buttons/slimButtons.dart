import 'package:flutter/material.dart';

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
