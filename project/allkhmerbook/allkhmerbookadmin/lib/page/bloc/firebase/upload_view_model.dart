import 'dart:async';

import 'package:allkhmerbookadmin/app/app.locator.dart';
import 'package:pisey_services/pisey_services.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:stacked_services/stacked_services.dart';
import 'package:file_picker/file_picker.dart';

class UploadViewModel extends BaseViewModel {
  final StorageService _firebaseStorageService = locator<StorageService>();
  final FirestoreService _realtimeDatabaseService = locator<FirestoreService>();
  final bottomsheet = locator<BottomSheetService>();
  final snackbar = locator<SnackbarService>();

  List<UploadModel>? _uploadModel = [];
  List<UploadModel>? get uploadModel => _uploadModel;

  void setUploadModel(List<PlatformFile>? list, String formname) {
    List<PlatformFile>? templist = list;
    if (!_uploadModel!.any((element) => element.formname == formname)) {
      templist!.asMap().forEach((key, value) {
        _uploadModel!.add(UploadModel(
            totalBytes: value.size,
            formname: formname,
            files: value,
            name: value.name,
            id: key));
      });
    } else {
      _uploadModel!.removeWhere((element) => element.formname == formname);
      templist!.asMap().forEach((key, value) {
        _uploadModel!.add(UploadModel(
            totalBytes: value.size,
            formname: formname,
            files: value,
            name: value.name,
            id: key));
      });
    }

    notifyListeners();
  }

  void removeListFile(UploadModel model, int index) {
    if (_uploadModel!.any((element) => element.formname == model.formname)) {
      // List<UploadModel>? listModel = _uploadModel!
      //     .where((element) => element.formname == model.formname)
      //     .toList();
      // listModel.forEach((value) {
      //   print(value.name);
      // });
      // _uploadModel!.removeWhere((element) => element.id == index);
    }
  }

  void cleaListFile() {
    if (_uploadModel!.isNotEmpty) {}
    _uploadModel!.clear();
    _dataMap!.clear();
    notifyListeners();
  }

  Map<String, dynamic>? _dataMap = {};
  Map<String, dynamic>? get dataMap => _dataMap;
  void setMapData(Map<String, dynamic> setdataMap) {
    _dataMap!.addAll(setdataMap);
    notifyListeners();
  }

  Future<void> uploadMultiFiles(
    String refWithoutName,
  ) async {
    setBusy(false);
    var doc = await _realtimeDatabaseService
        .setDataWithDocID('books', _dataMap!)
        .catchError((onError) {
      snackbar.showSnackbar(message: '$onError');
    });
    _uploadModel!.forEach((element1) {
      int index = _uploadModel!.indexWhere((element2) =>
          element1.formname == element2.formname &&
          element1.timestamp == element2.timestamp &&
          element1.name == element2.name);
      _uploadModel![index].state = firebase_storage.TaskState.running;
      _firebaseStorageService
          .uploadData(
              element1.files!.bytes!,
              // refWithoutName +
              //     '${_dataMap!['grade']}/' +
              //     '${element1.files!.name}'
              '${doc!.path}/${element1.files!.name}')
          .catchError((onError) {
        snackbar.showSnackbar(message: '$onError');
      }).then((event) {
        event.snapshotEvents.listen((snapshot) async {
          _uploadModel![index].byteTransfer = snapshot.bytesTransferred;
          switch (snapshot.state) {
            case firebase_storage.TaskState.paused:
              setBusy(false);
              await event.cancel();
              break;
            case firebase_storage.TaskState.running:
              setBusy(true);
              break;
            case firebase_storage.TaskState.success:
              _uploadModel![index].state = firebase_storage.TaskState.success;
              var url =
                  await snapshot.ref.getDownloadURL().catchError((onError) {
                snackbar.showSnackbar(message: '$onError');
              });
              await _realtimeDatabaseService.updateData(doc.path, {
                '${element1.formname}_Url_${element1.id}': url
              }).catchError((onError) {
                snackbar.showSnackbar(message: '$onError');
              });

              setBusy(false);

              break;
            case firebase_storage.TaskState.canceled:
              setBusy(false);
              break;
            case firebase_storage.TaskState.error:
              setBusy(false);
              await event.cancel();
              break;
          }
          notifyListeners();
        }, onError: (onError) {
          snackbar.showSnackbar(message: '$onError');
        });
      });
    });
    notifyListeners();
  }
}
