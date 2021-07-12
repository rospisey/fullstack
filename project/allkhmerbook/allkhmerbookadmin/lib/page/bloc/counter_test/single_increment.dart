import 'package:allkhmerbookadmin/page/bloc/counter_test/single_increment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SingleIncrement extends StatelessWidget {
  const SingleIncrement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleViewModel>.reactive(
        builder: (context, singleModel, singleChild) {
          return GestureDetector(
            onTap: singleModel.updateCounter,
            child: Container(
              child: Column(
                children: [Text('single increament ${singleModel.counter}')],
              ),
            ),
          );
        },
        viewModelBuilder: () => SingleViewModel());
  }
}
