import 'dart:ui';

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

class RawButton extends StatefulWidget {
  const RawButton({
    Key key,
    @required this.builder,
    @required this.onPressed,
  }) : super(key: key);

  final Widget Function(bool) builder;
  final Function onPressed;

  @override
  _RawButtonState createState() => _RawButtonState();
}

class _RawButtonState extends State<RawButton> {
  bool isPressed = false;

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      onTapDown: (details) => setState(() {
        isPressed = true;
      }),
      onTapUp: (details) => setState(() {
        isPressed = false;
      }),
      onTapCancel: () => setState(() {
        isPressed = false;
      }),
      child: Container(child: widget.builder(isPressed)),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key key,
    @required this.label,
    @required this.onPressed,
    this.color = Colors.black,
  }) : super(key: key);

  final Color color;
  final String label;
  final Function onPressed;

  @override
  Widget build(context) {
    return RawButton(
      builder: (isPressed) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Text(label),
          color: isPressed ? Colors.red : color,
        );
      },
      onPressed: onPressed,
    );
  }
}

class Modal extends StatelessWidget {
  Modal({this.child});

  final Widget child;

  @override
  Widget build(context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF222222),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.fromLTRB(20, 50, 20, 50),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Button(
                label: 'X',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
