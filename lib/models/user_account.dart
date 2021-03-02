import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserAccount {
  static Future<String> get displayName async {
    var isLogged = await FacebookAuth.instance.isLogged;
    if (isLogged == null) {
      return FirebaseAuth.instance?.currentUser?.displayName ??
          'Ajolote anónimo';
    } else {
      var userData = await FacebookAuth.instance.getUserData();
      return userData['name'] ?? '<error al obtener tu nombre>';
    }
  }

  static Future<String> get email async {
    var isLogged = await FacebookAuth.instance.isLogged;
    if (isLogged == null) {
      return FirebaseAuth.instance.currentUser?.email ?? 'Correo no aplicable';
    } else {
      var userData = await FacebookAuth.instance.getUserData();
      return userData['email'];
    }
  }

  static Future<String> get profilePicUrl async {
    var isLogged = await FacebookAuth.instance.isLogged;
    if (isLogged == null) {
      return FirebaseAuth.instance.currentUser?.photoURL;
    } else {
      var userData = await FacebookAuth.instance.getUserData();
      return userData['picture']['data']['url'];
    }
  }
}
