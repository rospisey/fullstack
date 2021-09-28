part of pisey_services;

/// Field for image(s) from user device storage
class FormBuilderFilePicker extends FormBuilderField<List<PlatformFile>> {
  /// Maximum number of files needed for this field
  final int? maxFiles;

  /// Allows picking of multiple files
  final bool allowMultiple;

  /// If set to true, a thumbnail of image files will be shown; else the default
  /// icon will be displayed depending on file type
  final bool previewImages;

  /// Widget to be tapped on by user in order to pick files
  final Widget selector;

  /// Default types of files to be picked. Default set to [FileType.any]
  final FileType type;

  /// Allowed file extensions for files to be selected
  final List<String>? allowedExtensions;

  /// If you want to track picking status, for example, because some files may take some time to be
  /// cached (particularly those picked from cloud providers), you may want to set [onFileLoading] handler
  /// that will give you the current status of picking.
  final void Function(FilePickerStatus)? onFileLoading;

  /// Whether to allow file compression
  final bool? allowCompression;

  /// If [withData] is set, picked files will have its byte data immediately available on memory as [Uint8List]
  /// which can be useful if you are picking it for server upload or similar.
  final bool withData;

  /// If [withReadStream] is set, picked files will have its byte data available as a [Stream<List<int>>]
  /// which can be useful for uploading and processing large files.
  final bool withReadStream;

  final void Function(int?)? onRemove;

  final Axis direction;

  final int count;

  final double? height;
  final double? spacing;
  final double? runSpacing;
  final List<Widget> Function(UploadModel)? listStackBuilder;
  final List<UploadModel> uploadModelList;

  /// Creates field for image(s) from user device storage
  FormBuilderFilePicker(this.uploadModelList,
      {
      //From Super
      Key? key,
      this.listStackBuilder,
      this.spacing,
      this.runSpacing,
      this.height,
      this.count = 3,
      required String name,
      FormFieldValidator<List<PlatformFile>>? validator,
      List<PlatformFile>? initialValue,
      InputDecoration decoration = const InputDecoration(),
      ValueChanged<List<PlatformFile>?>? onChanged,
      ValueTransformer<List<PlatformFile>?>? valueTransformer,
      bool enabled = true,
      FormFieldSetter<List<PlatformFile>>? onSaved,
      AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
      VoidCallback? onReset,
      FocusNode? focusNode,
      this.maxFiles = 1,
      this.withData = true,
      this.withReadStream = false,
      this.allowMultiple = false,
      this.previewImages = true,
      this.selector = const Icon(Icons.add_circle),
      this.type = FileType.any,
      this.allowedExtensions,
      this.onFileLoading,
      this.allowCompression = false,
      this.direction = Axis.horizontal,
      this.onRemove})
      : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: (list) {
            if (list != null) {
              if (list.any((element) =>
                  !allowedExtensions!.contains(element.extension!))) {
                return 'file type is unsupported';
              } else
                return validator!(list);
            } else {
              return validator!(list);
            }
          },
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<List<PlatformFile>?> field) {
            final state = field as _FormBuilderFilePickerState;

            if (field.value == null) {
              field._files!.clear();
            }

            // int index = formUploadModelList
            //     .indexWhere((element) => element.name == name);

            return InputDecorator(
              decoration: state.decoration(),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (maxFiles != null)
                        Text('${state._files!.length} / $maxFiles'),
                      PsButtonSplash(
                        onTap: state.enabled &&
                                (null == state._remainingItemCount ||
                                    state._remainingItemCount! > 0)
                            ? () => state
                                .pickFiles(field)
                                .catchError((e) => print('Pickfile error: $e '))
                            : null,
                        child: selector,
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  // if (field.value != null)
                  // if (formUploadModelList.isNotEmpty &&
                  //     formUploadModelList
                  //         .any((element) => element.name == name))
                  state.defaultFileViewer(state._files, field),
                ],
              ),
            );
          },
        );

  @override
  _FormBuilderFilePickerState createState() => _FormBuilderFilePickerState();
}

class _FormBuilderFilePickerState
    extends FormBuilderFieldState<FormBuilderFilePicker, List<PlatformFile>> {
  /// Image File Extensions.
  ///
  /// Note that images may be previewed.
  ///
  /// This list is inspired by [Image](https://api.flutter.dev/flutter/widgets/Image-class.html)
  /// and [instantiateImageCodec](https://api.flutter.dev/flutter/dart-ui/instantiateImageCodec.html):
  /// "The following image formats are supported: JPEG, PNG, GIF,
  /// Animated GIF, WebP, Animated WebP, BMP, and WBMP."
  static const imageFileExts = [
    'gif',
    'jpg',
    'jpeg',
    'png',
    'webp',
    'bmp',
    'dib',
    'wbmp',
  ];

  List<PlatformFile>? _files;
  int? get _remainingItemCount =>
      widget.maxFiles == null ? null : widget.maxFiles! - _files!.length;

  @override
  void initState() {
    super.initState();
    _files = widget.initialValue ?? [];
  }

  Future<void> pickFiles(FormFieldState<List<PlatformFile>?> field) async {
    FilePickerResult? resultList;

    try {
      if (kIsWeb) {
        resultList = await FilePicker.platform.pickFiles(
          type: widget.type,
          allowedExtensions: widget.allowedExtensions,
          allowCompression: widget.allowCompression!,
          onFileLoading: widget.onFileLoading,
          allowMultiple: widget.allowMultiple,
          withData: widget.withData,
          withReadStream: widget.withReadStream,
        );
      } else {
        if (await Permission.storage.request().isGranted) {
          resultList = await FilePicker.platform.pickFiles(
            type: widget.type,
            allowedExtensions: widget.allowedExtensions,
            allowCompression: widget.allowCompression!,
            onFileLoading: widget.onFileLoading,
            allowMultiple: widget.allowMultiple,
            withData: widget.withData,
            withReadStream: widget.withReadStream,
          );
        } else {
          throw Exception('Storage Permission not granted');
        }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (resultList != null) {
      // List<PlatformFile>? _files = [];
      _files!.addAll(resultList.files);
      setState(() => field.setValue(_files));

      field.didChange(_files);
      // widget.onChanged?.call(_files);
    }
  }

  void removeFileAtIndex(int index, FormFieldState<List<PlatformFile>?> field) {
    setState(() {
      field.value!.removeAt(index);
    });

    field.didChange(_files);
    widget.onChanged?.call(_files);
    if (_files == null) {
      widget.onRemove!(null);
    } else {
      widget.onRemove!(index);
    }
  }

  Widget defaultFileViewer(
      List<PlatformFile>? files, FormFieldState<List<PlatformFile>?> field) {
    // if (field.value == null) {
    //   this._files!.clear();
    //   widget.onChanged?.call(_files);
    // }
    return LayoutBuilder(
      builder: (context, constraints) {
        final theme = Theme.of(context);

        final itemSize = (constraints.biggest.width -
                (widget.count * (widget.spacing ?? 10))) /
            widget.count;
        return Wrap(
          direction: widget.direction,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          runSpacing: widget.runSpacing ?? 10,
          spacing: widget.spacing ?? 10,
          children: List.generate(
            files!.length,
            (index) {
              return Container(
                height: widget.height ?? itemSize,
                width: itemSize,
                margin: const EdgeInsets.only(right: 2),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: (imageFileExts.contains(
                                  files[index].extension!.toLowerCase()) &&
                              widget.previewImages)
                          ? (widget.withData
                              ? Image.memory(files[index].bytes!)
                              : Image.file(File(files[index].path!),
                                  fit: BoxFit.cover))
                          : Container(
                              alignment: Alignment.center,
                              color: theme.primaryColor,
                              child: Icon(
                                getIconData(files[index].extension!),
                                color: Colors.white,
                                size: 56,
                              ),
                            ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      width: double.infinity,
                      color: Colors.white.withOpacity(.8),
                      child: Text(
                        files[index].name,
                        style: theme.textTheme.caption,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    if (widget.listStackBuilder != null)
                      ...widget
                          .listStackBuilder!(widget.uploadModelList[index]),
                    if (enabled)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () => removeFileAtIndex(index, field),
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.7),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            height: 22,
                            width: 22,
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  IconData getIconData(String fileExtension) {
    final lowerCaseFileExt = fileExtension.toLowerCase();
    if (imageFileExts.contains(lowerCaseFileExt)) return Icons.image;
    // Check if the file is an image first (because there is a shared variable
    // with preview logic), and then fallback to non-image file ext lookup.
    switch (lowerCaseFileExt) {
      case 'doc':
      case 'docx':
        return Icons.file_download;
      case 'log':
        return Icons.file_download;
      case 'pdf':
        return Icons.file_download;
      case 'txt':
        return Icons.file_download;
      case 'xls':
      case 'xlsx':
        return Icons.file_download;
      default:
        return Icons.insert_drive_file;
    }
  }
}
