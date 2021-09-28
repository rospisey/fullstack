part of pisey_services;

class SharedPreferenceService {
  Future<String?> getStringUID(String uid) async {
    var data = await SharedPreferences.getInstance();
    return data.getString(uid);
  }

  Future<bool?> removeStringUID(String uid) async {
    var data = await SharedPreferences.getInstance();
    return data.remove(uid);
  }
}
