import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Settings extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("settings"),
        RaisedButton(child: Text("sound fx"), onPressed: () {}),
        RaisedButton(child: Text("music"), onPressed: () {}),
        RaisedButton(
            child: Text("credits"),
            onPressed: () {
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: RaisedButton(
                          child: Text("foo"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  });
            }),
        RaisedButton(child: Text("privacy policy"), onPressed: () {}),
      ],
    );
  }
}
