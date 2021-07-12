import 'package:allkhmerbookadmin/page/bloc/second/secondviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SecondView extends StatelessWidget {
  const SecondView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SecondviewModel>.reactive(
        builder: (context, model, chile) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                // SingleIncreaCounter(),
                SizedBox(
                  height: 50,
                ),
                // DoubleIncreaseCounter()
              ],
            ),
          );
        },
        viewModelBuilder: () => SecondviewModel());
  }
}
