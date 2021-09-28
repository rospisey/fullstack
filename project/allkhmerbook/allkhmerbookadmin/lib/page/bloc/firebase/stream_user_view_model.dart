import 'package:allkhmerbookadmin/app/app.locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pisey_services/pisey_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StreamUserList extends StreamViewModel<QuerySnapshot> {
  FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService =
      StackedLocator.instance.locator<DialogService>();
  @override
  Stream<QuerySnapshot> get stream =>
      _firestoreService.streamData(path: 'users/');
  @override
  void onError(error) {
    _dialogService.showDialog(
      description: '$error',
      title: 'User error state',
    );
  }
}
