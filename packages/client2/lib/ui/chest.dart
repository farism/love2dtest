import 'package:flutter/widgets.dart';

import './common.dart';
import '../state/app.dart';

class ChestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Chest"),
        Button(
          label: 'Back',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
