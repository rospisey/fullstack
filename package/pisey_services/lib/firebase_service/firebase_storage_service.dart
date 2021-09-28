part of pisey_services;

class StorageService {
  StorageService._();
  static final instance = StorageService._();

  final DialogService _dialogService =
      StackedLocator.instance.locator<DialogService>();

  // Future<storage.Reference> setFile(String path, Uint8List data,
  //     storage.SettableMetadata storageMetaData) async {
  //   // String filename = basename(file.path);
  //   storage.Reference ref = storage.FirebaseStorage.instance.ref(path);
  //   storage.UploadTask uploadTask;
  //   uploadTask = ref.putData(data, storageMetaData);
  //   // if (kIsWeb) {
  //   //   uploadTask = ref.putData(data, storageMetaData);
  //   // } else {
  //   //   uploadTask = ref.putFile(File(file.path), storageMetaData);
  //   // }
  //   if (uploadTask.snapshot.state == storage.TaskState.success) {
  //     print('success');
  //   }

  //   return Future.value(ref);
  // }

  storage.UploadTask? uploadData(Uint8List bytes, String ref) {
    try {
      storage.UploadTask uploadTask =
          storage.FirebaseStorage.instance.ref(ref).putData(bytes);
      return uploadTask;
    } on Exception catch (e) {
      _dialogService.showDialog(title: '$e');
    }
  }
}
