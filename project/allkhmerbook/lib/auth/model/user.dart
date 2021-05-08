import 'package:flutter/foundation.dart';

class UserModel {
  UserModel(
      {this.emailVerified,
      this.email,
      this.name,
      this.urlPhoto,
      @required this.uid});
  final String? uid;
  final String? email;
  final String? name;
  final String? urlPhoto;
  final bool? emailVerified;
  factory UserModel.fromMapEN(Map<String, dynamic> data, String docID) {
    final String name = data['name'];
    final String email = data['email'];
    final String urlPhoto = data['urlPhoto'];
    final bool emailVerified = data['emailverified'];
    return UserModel(
        uid: docID,
        name: name,
        email: email,
        urlPhoto: urlPhoto,
        emailVerified: emailVerified);
  }

  Map<String, dynamic> toMapEN() {
    return {'name': name, 'email': email, 'urlPhoto': urlPhoto};
  }
}
