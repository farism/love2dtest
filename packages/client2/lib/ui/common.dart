import 'dart:ui';

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

class Button extends StatefulWidget {
  const Button({
    Key key,
    @required this.label,
    @required this.onPressed,
    this.color = Colors.black,
  }) : super(key: key);

  final String label;
  final Function onPressed;
  final Color color;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isPressed = false;

  Widget build(context) {
    return GestureDetector(
      onTapDown: (details) => setState(() {
        isPressed = true;
      }),
      onTapUp: (details) => setState(() {
        isPressed = false;
        widget.onPressed();
      }),
      onTapCancel: () => setState(() {
        isPressed = false;
      }),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(widget.label),
        color: isPressed ? Colors.red : widget.color,
      ),
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
            Button(
              label: 'X',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            child
          ],
        ),
      ),
    );
  }
}
