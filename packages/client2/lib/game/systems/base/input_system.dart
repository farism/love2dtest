import 'package:flutter/gestures.dart';

import './system.dart';
import '../../../ui/gesture_widget.dart';

abstract class InputSystem extends BaseSystem {
  void gesture(GestureType gestureType, dynamic details) {
    if (gestureType == GestureType.onScaleEnd) {
      onScaleEnd(details);
    } else if (gestureType == GestureType.onScaleStart) {
      onScaleStart(details);
    } else if (gestureType == GestureType.onScaleUpdate) {
      onScaleUpdate(details);
    } else if (gestureType == GestureType.onTap) {
      onTap();
    } else if (gestureType == GestureType.onTapCancel) {
      onTapCancel();
    } else if (gestureType == GestureType.onTapDown) {
      onTapDown(details);
    } else if (gestureType == GestureType.onTapUp) {
      onTapUp(details);
    }
  }

  void onScaleEnd(ScaleEndDetails details) {}

  void onScaleStart(ScaleStartDetails details) {}

  void onScaleUpdate(ScaleUpdateDetails details) {}

  void onTap() {}

  void onTapCancel() {}

  void onTapDown(TapDownDetails details) {}

  void onTapUp(TapUpDetails details) {}
}
