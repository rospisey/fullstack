part of pisey_services;

class RealTimeService {
  RealTimeService._();
  static final instance = RealTimeService._();

  Future<void> setData(String path, Map<String, dynamic> data) async {
    final rtData = FirebaseDatabase.instance.reference().child('$path/');
    await rtData.set(data);
  }

  Future<String> setDataWithID(String path, Map<String, dynamic> data) async {
    final rtData = FirebaseDatabase.instance.reference().child(path).push();
    await rtData.set(data);
    return Future.value(rtData.path);
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    final rtData = FirebaseDatabase.instance.reference().child(path);
    await rtData.update(data);
  }

  Future<void> updateOnDisconnect(
      String path, Map<String, dynamic> data) async {
    final rtData = FirebaseDatabase.instance.reference().child(path);
    await rtData.onDisconnect().update(data);
  }
}
