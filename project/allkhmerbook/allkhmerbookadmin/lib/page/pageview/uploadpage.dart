import 'package:allkhmerbookadmin/page/bloc/firebase/upload_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart' as form;
import 'package:pisey_services/pisey_services.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';
import 'package:file_picker/file_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key, this.onSubmit, this.isLoading = false})
      : super(key: key);
  final Function(Map<String, dynamic>)? onSubmit;
  final bool isLoading;

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  static final List<Map<String, dynamic>> allTexts = [
    {
      'title': 'email',
      'pattern': 'RegexPattern.emailModel',
      'inputAction': 'TextInputAction.next',
      'keyType': 'TextInputType.emailAddress',
      'maxLines': 1,
      'minLines': 1
    },
    {
      'title': 'password',
      'pattern': 'RegexPattern.passwordEasyModel',
      'inputAction': 'TextInputAction.done',
      'keyType': 'TextInputType.emailAddress',
      'maxLines': 1,
      'minLines': 1
    }
  ];

  List<String> bookGrade = [
    'ថ្នាក់ទី១',
    'ថ្នាក់ទី២',
    'ថ្នាក់ទី៣',
    'ថ្នាក់ទី៤',
    'ថ្នាក់ទី៥',
    'ថ្នាក់ទី៦',
    'ថ្នាក់ទី៧',
    'ថ្នាក់ទី៨',
    'ថ្នាក់ទី៩',
    'ថ្នាក់ទី១០',
    'ថ្នាក់ទី១១',
    'ថ្នាក់ទី១២',
  ];
  List<String> bookType = [
    'សិស្ស',
    'គ្រូ',
    'កំណែ',
    'កិច្ចតែងការ',
  ];
  List<String> bookSubject = [
    'ភាសាខ្មែរ',
    'គណិតវិទ្យា',
    'វិទ្យាសាស្ត្រ',
    'សិក្សាសង្គម',
    'រូបវិទ្យា',
    'ជីវៈវិទ្យា',
    'គីមីវិទ្យា',
    'ផែនដីវិទ្យា',
    'ប្រវត្តិវិទ្យា',
    'ភូមិវិទ្យា',
  ];

  List<FocusNode> _focus = [for (int i = 0; i <= 5; i++) FocusNode()];

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  List<Map<String, dynamic>> _datalist = [
    {
      'name': 'PDF',
      'value': 'pdf',
      'regex': RegexPattern.pdfModel,
      'allowedExtensions': ['pdf']
    },
    {
      'name': 'IMAGE',
      'value': 'image',
      'regex': RegexPattern.imageModel,
      'allowedExtensions': [
        'gif',
        'jpg',
        'jpeg',
        'png',
        'webp',
        'bmp',
        'dib',
        'wbmp',
      ]
    },
    {
      'name': 'JSON',
      'value': 'json',
      'regex': RegexPattern.jsonModel,
      'allowedExtensions': ['json']
    },
  ];

  bool _isLoading = false;

  Future<void> saveAndSubmit() async {
    try {
      if (_formKey.currentState!.validate()) {
        _toggleLoading();
        await Future.delayed(Duration(seconds: 1)).catchError((e) {
          print('Error: $e');
          _toggleLoading();
        }).then(
          (value) {
            // widget.onSubmit!(_formKey.currentState!.value);
            _toggleLoading();
          },
        );
      }
    } catch (e) {
      _toggleLoading();
      print(e);
    }
  }

  FocusNode? focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
  }

  final _formKey = GlobalKey<form.FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UploadViewModel>.reactive(
        builder: (context, uploadModel, uploadChild) {
          return buildScaffold(context, uploadModel);
        },
        viewModelBuilder: () => UploadViewModel());
  }

  Scaffold buildScaffold(BuildContext context, UploadViewModel uploadModel) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: form.FormBuilder(
          skipDisabled: true,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // _ListenState(),
                // form.FormBuilderField(
                //   name: 'grade',
                //   validator: form.FormBuilderValidators.required(context),
                //   builder: (FormFieldState<dynamic> field) {
                //     return InputDecorator(
                //       decoration: InputDecoration(errorText: field.errorText),
                //       child: MyDropDownButton(
                //           onChanged: (val) {
                //             setState(() {
                //               _bookgrade = val as String;
                //               field.didChange(_bookgrade);
                //             });
                //             print(field.validate());
                //           },
                //           valueSelected: _bookgrade,
                //           categories: bookGrade.map((e) => e).toList()),
                //     );
                //   },
                // ),
                form.FormBuilderDropdown(
                  onChanged: (st) {
                    uploadModel.setMapData({'grade': st});
                  },
                  name: 'grade',
                  hint: Text('Choose grade'),
                  validator: form.FormBuilderValidators.required(context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: bookGrade
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                ),
                form.FormBuilderRadioGroup(
                  onChanged: (st) {
                    uploadModel.setMapData({'bookSubject': st});
                  },
                  name: 'bookSubject',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: form.FormBuilderValidators.required(context),
                  options: bookSubject
                      .map((e) => form.FormBuilderFieldOption(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                ),
                if (uploadModel.dataMap != null) Text('${uploadModel.dataMap}'),
                form.FormBuilderSegmentedControl(
                  onChanged: (st) {
                    uploadModel.setMapData({'bookType': st});
                  },
                  enabled: true,
                  name: 'bookType',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: form.FormBuilderValidators.required(context),
                  options: bookType
                      .map((e) => form.FormBuilderFieldOption(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 15,
                ),
                if (uploadModel.uploadModel!.isNotEmpty) _ListenState(),

                _FilePickerPDF(),
                // _FilePickerImage(),
                _FilePickerJSON(),

                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PsButtonBouncing(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          uploadModel.uploadMultiFiles('books/');
                          // await saveAndSubmit().catchError((e) => print(e));
                          // .then((value) => _formKey.currentState!.reset());
                        } else {
                          print("validation failed");
                        }
                      },
                      margin: myMargin(left: 0, bottom: 0, right: 0, top: 0),
                      borderRadius: 10,
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: uploadModel.isBusy
                              ? CircularProgressIndicator()
                              : Text('Submit',
                                  textAlign: TextAlign.center,
                                  style: myDefaultTextStylePtSans(context)),
                        ),
                      ),
                    ),
                    PsButtonBouncing(
                      onTap: () async {
                        _formKey.currentState!.reset();
                        uploadModel.cleaListFile();
                      },
                      margin: myMargin(left: 0, bottom: 0, right: 0, top: 0),
                      borderRadius: 10,
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: Text('Reset',
                              textAlign: TextAlign.center,
                              style: myDefaultTextStylePtSans(context)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            // shrinkWrap: true,
          ),
        ),
      ),
    );
  }

  Column listFormField(MapEntry<int, FocusNode> focus, BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            allTexts[focus.key]['title'],
            style: myDefaultTextStylePtSans(context),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        form.FormBuilderTextField(
          decoration: InputDecoration(
            hintText: allTexts[focus.key]['title'],
            //prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
            labelStyle: TextStyle(color: Colors.grey),
            hintStyle: TextStyle(color: Colors.grey),
            counterStyle: TextStyle(color: Colors.grey),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          name: allTexts[focus.key]['title'],
          validator: form.FormBuilderValidators.compose([
            form.FormBuilderValidators.required(context),
            form.FormBuilderValidators.match(
                context,
                toTextStringPatternModel(allTexts[focus.key]['pattern'])
                    .pattern
                    .toString(),
                errorText:
                    toTextStringPatternModel(allTexts[focus.key]['pattern'])
                        .errorText),
          ]),
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction:
              toTextInputAction(allTexts[focus.key]['inputAction']),
          focusNode: focus.value,
          keyboardType: toTextInputType(allTexts[focus.key]['keyType']),
          onEditingComplete: () {
            if (focus.key < _focus.length - 1) {
              if (allTexts[focus.key]['inputAction'] ==
                  'TextInputAction.next') {
                FocusScope.of(context).requestFocus(_focus[focus.key + 1]);
              }
            } else if (focus.key <= _focus.length - 1) {
              if (allTexts[focus.key]['inputAction'] ==
                  'TextInputAction.previous') {
                FocusScope.of(context).requestFocus(_focus[focus.key - 1]);
              } else if (allTexts[focus.key]['inputAction'] ==
                      'TextInputAction.done' ||
                  allTexts[focus.key]['inputAction'] ==
                      'TextInputAction.none') {
                FocusScope.of(context).unfocus();
              } else if (allTexts[focus.key]['inputAction'] ==
                  'TextInputAction.newline') {
                return null;
              } else {
                saveAndSubmit();
              }
            }
          },
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}

class _ListenState extends ViewModelWidget<UploadViewModel> {
  _ListenState({Key? key}) : super(key: key, reactive: true);
  @override
  Widget build(BuildContext context, UploadViewModel viewModel) {
    return Text('${viewModel.uploadModel!.map((e) => e.toMap()).toList()} ');
  }
}

class _FilePickerPDF extends ViewModelWidget<UploadViewModel> {
  _FilePickerPDF({Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, UploadViewModel viewModel) {
    return FormBuilderFilePicker(
      viewModel.uploadModel!,
      direction: Axis.horizontal,
      count: 2,
      height: 80,
      spacing: 10,
      runSpacing: 10,
      name: 'pdf',
      selector: Row(
        children: <Widget>[
          Icon(Icons.file_upload),
          Text('Upload'),
        ],
      ),
      decoration: InputDecoration(
        labelText: 'PDF',
      ),
      listStackBuilder: (model) {
        return [
          Positioned.fill(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: model.byteTransfer != null
                  ? ((model.byteTransfer! * MediaQuery.of(context).size.width) /
                      model.totalBytes!)
                  : 0,
              color: Colors.white.withOpacity(0.5),
            ),
          )),
          if (model.state == firebase_storage.TaskState.success)
            Positioned.fill(
                child: Align(
                    alignment: Alignment.center, child: Icon(Icons.check))),
        ];
      },
      onChanged: (list) {
        viewModel.setUploadModel(list!, 'pdf');
      },
      validator: form.FormBuilderValidators.required(context),
      withData: true,
      maxFiles: 2,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
  }
}

class _FilePickerImage extends ViewModelWidget<UploadViewModel> {
  _FilePickerImage({Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, UploadViewModel viewModel) {
    return FormBuilderFilePicker(
      viewModel.uploadModel!,
      direction: Axis.horizontal,
      count: 2,
      height: 80,
      spacing: 10,
      runSpacing: 10,
      name: 'image',
      type: FileType.image,
      validator: form.FormBuilderValidators.required(context),
      decoration: InputDecoration(
        labelText: 'IMAGE',
      ),
      selector: Row(
        children: <Widget>[
          Icon(Icons.file_upload),
          Text('Upload'),
        ],
      ),
      onChanged: (list) {},
      onRemove: (list) {},
      withData: true,
      allowMultiple: true,
      maxFiles: 2,
      previewImages: true,
    );
  }
}

class _FilePickerJSON extends ViewModelWidget<UploadViewModel> {
  _FilePickerJSON({Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, UploadViewModel viewModel) {
    return FormBuilderFilePicker(
      viewModel.uploadModel!,
      direction: Axis.horizontal,
      count: 2,
      height: 80,
      spacing: 10,
      runSpacing: 10,
      name: 'json',
      selector: Row(
        children: <Widget>[
          Icon(Icons.file_upload),
          Text('Upload'),
        ],
      ),
      decoration: InputDecoration(
        labelText: 'JSON',
      ),
      listStackBuilder: (model) {
        return [
          Positioned.fill(
              child: Align(
            alignment: Alignment.center,
            child: Container(
              width: model.byteTransfer != null
                  ? ((model.byteTransfer! * MediaQuery.of(context).size.width) /
                      model.totalBytes!)
                  : 0,
              color: Colors.white.withOpacity(0.5),
            ),
          )),
          if (model.state == firebase_storage.TaskState.success)
            Positioned.fill(
                child: Align(
                    alignment: Alignment.center, child: Icon(Icons.check))),
        ];
      },
      onChanged: (list) {
        viewModel.setUploadModel(list!, 'json');
      },
      validator: form.FormBuilderValidators.required(context),
      withData: true,
      maxFiles: 1,
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
  }
}
