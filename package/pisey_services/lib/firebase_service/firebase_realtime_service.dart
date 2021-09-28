part of pisey_services;

class RealTimeService {
  RealTimeService._();
  static final instance = RealTimeService._();

  final DialogService _dialogService =
      StackedLocator.instance.locator<DialogService>();

  Future<void> setData(String path, Map<String, dynamic> data) async {
    try {
      final rtData = FirebaseDatabase.instance.reference().child('$path/');
      return await rtData.set(data);
    } on Exception catch (e) {
      _dialogService.showDialog(title: '$e');
    }
  }

  Future<String?> setDataWithID(String path, Map<String, dynamic> data) async {
    try {
      final rtData = FirebaseDatabase.instance.reference().child(path).push();
      await rtData.set(data);
      return Future.value(rtData.path);
    } on Exception catch (e) {
      _dialogService.showDialog(title: '$e');
    }
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    try {
      final rtData = FirebaseDatabase.instance.reference().child(path);
      return await rtData.update(data);
    } on Exception catch (e) {
      _dialogService.showDialog(title: '$e');
    }
  }

  Future<void> updateOnDisconnect(
      String path, Map<String, dynamic> data) async {
    try {
      final rtData = FirebaseDatabase.instance.reference().child(path);
      return await rtData.onDisconnect().update(data);
    } on Exception catch (e) {
      _dialogService.showDialog(title: '$e');
    }
  }
}
