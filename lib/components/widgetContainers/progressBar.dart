import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.progress,
      this.color})
      : super(key: key);
  final Color color;
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
                color: color ?? Colors.green,
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
                      ProgressStar(
                        width: width,
                        progress: progress,
                        guage: .66,
                      ),
                      ProgressStar(
                        width: width,
                        progress: progress,
                        guage: .76,
                      ),
                      ProgressStar(
                        width: width,
                        progress: progress,
                        guage: .9,
                      ),
                    ],
                  ),
                )))
      ]),
    );
  }
}

class ProgressStar extends StatelessWidget {
  const ProgressStar({
    Key key,
    @required this.width,
    @required this.progress,
    @required this.guage,
  }) : super(key: key);

  final double width;
  final double progress;
  final double guage;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 10,
      child: Icon(
        Icons.star,
        size: width * .09,
        color: progress > guage ? Colors.yellow[800] : Colors.grey,
      ),
    );
  }
}
