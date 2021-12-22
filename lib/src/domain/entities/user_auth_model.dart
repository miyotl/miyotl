import 'dart:convert';

import '../../presentation/utils/constants/key_constants.dart';

class UserAuthModel {
  String? displayName;
  String? email;
  String? id;
  String? photoUrl;
  String? token;

  UserAuthModel(
      {this.displayName, this.email, this.id, this.photoUrl, this.token});

  UserAuthModel.fromJson(Map<String, dynamic> json) {
    displayName = json[KeyConstants.googleDisplayName];
    email = json[KeyConstants.googleEmail];
    id = json[KeyConstants.googleId];
    photoUrl = json[KeyConstants.googlePhotoUrl];
    token = json[KeyConstants.googleToken];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[KeyConstants.googleDisplayName] = "$displayName";
    data[KeyConstants.googleEmail] = "$email";
    data[KeyConstants.googleId] = "$id";
    data[KeyConstants.googlePhotoUrl] = "$photoUrl";
    data[KeyConstants.googleToken] = "$token";
    return data;
  }

  String toString() {
    var str = json.encode(toJson());
    return str;
  }
}
