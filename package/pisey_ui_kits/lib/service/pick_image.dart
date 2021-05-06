part of pisey_ui_kits;

// class ImageCompress {
//   // final picker = ImagePicker();
//   Future<File> getImaageFile(ImageSource source) async {
//     var image = await ImagePicker().getImage(source: source);
//     // File croppedFile = await ImageCropper.cropImage(
//     //     sourcePath: image.path,
//     //     aspectRatioPresets: [
//     //       CropAspectRatioPreset.square,
//     //       CropAspectRatioPreset.ratio3x2,
//     //       CropAspectRatioPreset.original,
//     //       CropAspectRatioPreset.ratio4x3,
//     //       CropAspectRatioPreset.ratio16x9
//     //     ],
//     //     maxHeight: 512,
//     //     maxWidth: 512,
//     //     androidUiSettings: AndroidUiSettings(
//     //         toolbarTitle: 'Cropper',
//     //         toolbarColor: Colors.deepOrange,
//     //         toolbarWidgetColor: Colors.white,
//     //         initAspectRatio: CropAspectRatioPreset.original,
//     //         lockAspectRatio: false),
//     //     iosUiSettings: IOSUiSettings(
//     //       minimumAspectRatio: 1.0,
//     //     ));
//     // print('Image size ${image.lengthSync()}');
//     var result = await FlutterImageCompress.compressAndGetFile(
//       image.path,
//       image.path,
//       quality: 70,
//       rotate: 0,
//     );
//     print('Compressed size ${result.lengthSync()}');
//     return result;
//     // setState(() {
//     //   _image = result;
//     // });
//   }
// }

Future<PickedFile> getImaageFile(ImageSource source) async {
  var image = await ImagePicker().getImage(
    source: source,
  );
  return image!;
}

// Future<File> compressAndGetFileThumbnail(File file) async {
//   print("testCompressAndGetFile");
//   final dir = await path_provider.getTemporaryDirectory();
//   final targetPath = dir.absolute.path + "/temp.jpg";
//   final result = await FlutterImageCompress.compressAndGetFile(
//     file.absolute.path,
//     targetPath,
//     quality: 50,
//     minWidth: 128,
//     minHeight: 128,
//   );

//   // print(file.lengthSync());
//   print('thumbnail sized ${result.lengthSync()}');

//   return result!;
// }

// Future<File> compressAndGetFileImage(File file) async {
//   print("testCompressAndGetFile");
//   final dir = await path_provider.getTemporaryDirectory();
//   final targetPath =
//       dir.absolute.path + "/image" + file.lengthSync().toString() + ".jpg";
//   final result = await FlutterImageCompress.compressAndGetFile(
//     file.absolute.path,
//     targetPath,
//     quality: 70,
//     minWidth: 1024,
//     minHeight: 1024,
//   );

//   print(targetPath);

//   // print(file.lengthSync());
//   print('image sized ${result!.lengthSync()}');

//   return result;
// }
