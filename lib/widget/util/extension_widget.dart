import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  List<Widget> divider() {
    return [
      this,
      const Divider(),
    ];
  }

  Wrap wrap(Axis direction) {
    return Wrap(
      direction: direction,
      children: [this],
    );
  }

  Flexible flexible() {
    return Flexible(child: this);
  }

  Visibility visibility(bool visible) {
    return Visibility(
      child: this,
      visible: visible,
      maintainSize: true,
      maintainState: true,
      maintainAnimation: true,
    );
  }

  Center center() {
    return Center(
      child: this,
    );
  }
}

extension WidgetsExtension on List<Widget> {
  List<Widget> divider() {
    return [
      ...this,
      const Divider(),
    ];
  }

  Wrap wrap(Axis direction) {
    return Wrap(
      direction: direction,
      children: this,
    );
  }
}
