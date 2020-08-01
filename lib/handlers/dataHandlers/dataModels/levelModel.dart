import 'dart:math';

import 'package:flutter/material.dart';

class LevelModel {
  final double displace;
  final Color color;
  final String label;

  LevelModel({this.displace, this.color, this.label});
}

Map levelMap = {
  'displace': List<double>.generate(
    100,
    (i) {
      double x = Random().nextDouble();
      double y = Random().nextDouble();
      double z = Random().nextDouble();
       double a = Random().nextDouble();
      double b = Random().nextDouble();
      double k = Random().nextDouble();
       double d = Random().nextDouble();
      double e= Random().nextDouble();
      double f = Random().nextDouble();
       double g = Random().nextDouble();
      double h= Random().nextDouble();
      double j = Random().nextDouble();
      List c = [x, y, z,a,b,j,d,e,f,g,h,i,k];

      return c.firstWhere((element) => element < .5 && element>.1);
    },
  )
};
