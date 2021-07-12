part of pisey_services;

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  final DialogService _dialogService =
      StackedLocator.instance.locator<DialogService>();

  Future<void> setData(String path, Map<String, dynamic> data) async {
    final database = FirebaseFirestore.instance.doc('$path');
    await database.set(data);
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    final database = FirebaseFirestore.instance.doc('$path');
    await database.update(data);
  }

  Future<void> deleteData({String? path}) async {
    final database = FirebaseFirestore.instance.doc(path!);
    await database.delete();
  }

  Future<DocumentReference?> setDataWithDocID(
      String col, Map<String, dynamic> data) async {
    try {
      return await FirebaseFirestore.instance.collection(col).add(data);
    } catch (e) {
      _dialogService.showDialog(description: '${e}');
    }
  }

  Stream<List<T>> setStream<T>(
      {@required
          String? path,
      @required
          T builder(
        Map<String, dynamic> data,
        String docID,
      )?}) {
    final reference = FirebaseFirestore.instance.collection(path!);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs
        .map((snapshot) => builder!(
              snapshot.data(),
              snapshot.id,
            ))
        .toList());
  }

  Stream<List<T>> setOrderStream<T>(
      {@required
          String? path,
      @required
          String? orderBy,
      @required
          T builder(
        Map<String, dynamic> data,
        String docID,
      )?}) {
    final reference =
        FirebaseFirestore.instance.collection(path!).orderBy(orderBy);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs
        .map((snapshot) => builder!(
              snapshot.data(),
              snapshot.id,
            ))
        .toList());
  }

  Stream<List<T>> setSearchStream<T>(
      {@required
          String? path,
      @required
          String? searchString,
      @required
          String? searchIndex,
      @required
          T builder(
        Map<String, dynamic> data,
        String docID,
      )?}) {
    final reference = FirebaseFirestore.instance
        .collection(path!)
        .where(searchIndex, arrayContains: searchString);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs
        .map((snapshot) => builder!(
              snapshot.data(),
              snapshot.id,
            ))
        .toList());
  }
}
