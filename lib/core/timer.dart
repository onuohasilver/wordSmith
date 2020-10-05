import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/abstract.dart';

void widgetTimer(AbstractData abstract) {
  Timer.periodic(Duration(seconds: 1), (timer) {
    if (abstract.counter > 0) {
      abstract.setDisplay(true);
      abstract.reduceCounter();
    } else {
      abstract.setDisplay(false);
      abstract.resetCounter();
      timer.cancel();
    }
  });
}

class TimedWidget extends StatelessWidget {
  const TimedWidget({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    AbstractData abstract = Provider.of<AbstractData>(context);
    return abstract.display ? child : Text('Nothing');
  }
}
