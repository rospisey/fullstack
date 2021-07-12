import 'package:allkhmerbookadmin/page/bloc/counter_test/double_increment.dart';
import 'package:allkhmerbookadmin/page/bloc/counter_test/single_increment.dart';
import 'package:allkhmerbookadmin/page/bloc/firebase/upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';
import 'package:stacked/stacked.dart';

import 'homeviewmodel.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pisey_services/pisey_services.dart';

class Homeview extends StatelessWidget {
  const Homeview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InternetViewModel>.reactive(
        builder: (context, internetModel, internetWidget) {
          return ViewModelBuilder<UploadViewModel>.reactive(
            builder: (context, uploadModel, uploadWidget) {
              return Scaffold(
                appBar: AppBar(),
                body: Column(
                  children: [
                    // _StringForm(),
                    SingleIncrement(),
                    DoubleIncrement(),
                    Text(
                      'Image',
                      style: myDefaultTextStylePtSans(context),
                    ),

                    // GestureDetector(
                    //   onTap: () => uploadModel.selectImage(),
                    //   child: Container(
                    //       height: 200,
                    //       width: MediaQuery.of(context).size.width,
                    //       padding: myMargin(),
                    //       margin: myMargin(),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(5),
                    //           color: Colors.grey.shade200),
                    //       child: uploadModel.bytesFile != null
                    //           ? (Image.memory(uploadModel.bytesFile!))
                    //           : Container()),
                    // ),

                    // if (uploadModel.taskState != null)
                    //   Text(uploadModel.taskState.toString())
                    // _Title(),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    // uploadModel.uploadToFirebase('image.jpg');
                  },
                ),
              );
            },
            viewModelBuilder: () => UploadViewModel(),
          );
        },
        initialiseSpecialViewModelsOnce: true,
        viewModelBuilder: () => InternetViewModel());
  }
}

class _StringForm extends HookViewModelWidget<HomeviewModel> {
  _StringForm({Key? key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, HomeviewModel viewModel) {
    var text = useTextEditingController();
    return TextField(
      controller: text,
      onChanged: viewModel.onChange,
    );
  }
}

class _Title extends ViewModelWidget<HomeviewModel> {
  _Title({Key? key}) : super(key: key, reactive: true);
  @override
  Widget build(BuildContext context, HomeviewModel viewModel) {
    return Text(
      viewModel.title,
      style: myDefaultTextStylePtSans(context),
    );
  }
}
