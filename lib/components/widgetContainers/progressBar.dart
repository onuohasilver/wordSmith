import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key key,
    @required this.height,
    @required this.width,
    @required this.progress,
  }) : super(key: key);

  final double height;
  final double width;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * .044,
      width: width,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(10),
            ),
            height: height * .014,
            width: width,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10)),
            height: height * .014,
            width: width * progress,
          ),
        ),
        Positioned.fill(
            child: Align(
                alignment: Alignment.topRight,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        size: width * .09,
                        color: progress > .66
                            ? Colors.orange[800]
                            : Colors.grey,
                      ),
                      Icon(
                        Icons.star,
                        size: width * .09,
                        color: progress > .76
                            ? Colors.orange[800]
                            : Colors.grey,
                      ),
                      Icon(
                        Icons.star,
                        size: width * .09,
                        color: progress > .9
                            ? Colors.orange[800]
                            : Colors.grey,
                      ),
                    ],
                  ),
                )))
      ]),
    );
  }
}
