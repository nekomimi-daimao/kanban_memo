import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  List<Widget> divider() {
    return [
      this,
      const Divider(
        thickness: 4,
      ),
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

  Padding padding(EdgeInsets insets) {
    return Padding(
      padding: insets,
      child: this,
    );
  }

  Center center() {
    return Center(
      child: this,
    );
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
}

extension WidgetsExtension on List<Widget> {
  List<Widget> divider() {
    return [
      ...this,
      const Divider(
        thickness: 4,
      ),
    ];
  }

  Wrap wrap(Axis direction) {
    return Wrap(
      direction: direction,
      children: this,
    );
  }
}
