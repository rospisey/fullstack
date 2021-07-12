import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class FilePickService {
  Future<Uint8List> selectImage() async {
    var pickFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    var bytes = await pickFile!.readAsBytes();
    return bytes;
  }
}
