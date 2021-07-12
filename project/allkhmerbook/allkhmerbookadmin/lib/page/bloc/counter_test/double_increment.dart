import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'double_increment_view_model.dart';

class DoubleIncrement extends StatelessWidget {
  const DoubleIncrement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoubleIncrementViewModel>.reactive(
        builder: (context, doubleModel, singleChild) {
          return GestureDetector(
            onTap: doubleModel.updateCounter,
            child: Container(
              height: 50,
              child: Column(
                children: [Text('double increament ${doubleModel.counter}')],
              ),
            ),
          );
        },
        viewModelBuilder: () => DoubleIncrementViewModel());
  }
}
