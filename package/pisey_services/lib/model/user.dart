part of pisey_services;

class UserModel {
  UserModel(
      {this.emailVerified,
      this.auth,
      this.name,
      this.urlPhoto,
      this.data,
      this.presence,
      this.lastSeenInEpoch,
      @required this.uid});
  final String? uid;
  final Map? data;
  final String? auth;
  final String? name;
  final String? urlPhoto;
  final bool? emailVerified;
  final bool? presence;
  final int? lastSeenInEpoch;
  factory UserModel.fromMapEN(dynamic data, String docID) {
    // final String name = data['name'];
    // final String email = data['email'];
    // final String urlPhoto = data['urlPhoto'];
    // final bool emailVerified = data['emailverified'];
    final presence = data['presence'];
    final lastSeenInEpoch = data['lastSeenInEpoch'];
    return UserModel(
      uid: docID,
      // name: name,
      // email: email,
      // urlPhoto: urlPhoto,
      // emailVerified: emailVerified,
      presence: presence,
      lastSeenInEpoch: lastSeenInEpoch,
    );
  }

  Map<String, dynamic> toMapUser() {
    return {
      'name': name,
      'auth': auth,
      'presence': presence,
      'lastSeenInEpoch': lastSeenInEpoch
    };
  }

  Map<String, dynamic> toMapUserPresence() {
    return {'presence': presence, 'lastSeenInEpoch': lastSeenInEpoch};
  }
}
