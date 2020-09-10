import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar(
      {Key key,
      @required this.progress,
      this.color = Colors.green,
      this.height,
      this.width})
      : super(key: key);
  final Color color;
  final double height;
  final double width;
  final double progress;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                color: color, borderRadius: BorderRadius.circular(10)),
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
      child: Stack(
        children: <Widget>[
          Icon(
            Icons.star,
            size: width * .10,
            color: progress > guage ? Colors.red[800] : Colors.black,
          ),
          Center(
            child: Icon(
              Icons.star,
              size: width * .09,
              color: progress > guage ? Colors.yellow[800] : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
