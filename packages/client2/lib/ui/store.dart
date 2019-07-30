import 'package:flutter/widgets.dart';

import './common.dart';
import '../state/app.dart';
import '../state/ui.dart';

class StoreRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Store"),
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
