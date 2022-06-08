// @dart=2.9

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAccount extends ChangeNotifier {
  String displayName;
  String email;
  String profilePicUrl;
  ImageProvider profilePic;
  bool loading;
  FirebaseApp firebaseApp;
  static UserAccount _instance;

  UserAccount() {
    _instance = this;
    init();
  }

  Future<String> getDisplayName() async {
    var isLogged = await FacebookAuth.instance.accessToken;
    if (isLogged == null) {
      // Use saved name if Apple.
      if ((FirebaseAuth.instance.currentUser?.providerData?.isNotEmpty ??
              false) &&
          FirebaseAuth.instance.currentUser?.providerData
                  ?.elementAt(0)
                  ?.providerId ==
              'apple.com') {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString('apple-name');
      } else {
        return FirebaseAuth.instance?.currentUser?.displayName ??
            'Ajolote anónimo';
      }
    } else {
      var userData = await FacebookAuth.instance.getUserData();
      return userData['name'] ?? '<error al obtener tu nombre>';
    }
  }

  Future<String> getEmail() async {
    var isLogged = await FacebookAuth.instance.accessToken;
    if (isLogged == null) {
      /// TODO: use providerData?[0] after migrating to null-safety
      if (FirebaseAuth.instance.currentUser?.providerData?.isNotEmpty ??
          false) {
        return FirebaseAuth.instance.currentUser?.providerData
            ?.elementAt(0)
            ?.email;
      } else {
        return FirebaseAuth.instance.currentUser?.email ??
            'Correo no aplicable';
      }
    } else {
      var userData = await FacebookAuth.instance.getUserData();
      return userData['email'];
    }
  }

  Future<String> getProfilePicUrl() async {
    var isLogged = await FacebookAuth.instance.accessToken;
    if (isLogged == null) {
      return FirebaseAuth.instance.currentUser?.photoURL;
    } else {
      // TODO this doesn't make sense :/
      var userData = await FacebookAuth.instance.getUserData();
      return userData['picture']['data']['url'];
    }
  }

  Future<String> getDebugAccountDetails() async {
    var isLogged = await FacebookAuth.instance.accessToken;
    if (isLogged == null) {
      return FirebaseAuth.instance.currentUser.toString();
    } else {
      var userData = await FacebookAuth.instance.getUserData();
      return userData.toString();
    }
  }

  Future<void> cacheUserAccount() async {
    displayName = await getDisplayName();
    if (displayName == '' || displayName == null) {
      displayName = 'Ajolote anónimo';
    }
    email = await getEmail();
    if (email == '' || email == null) {
      email = 'Correo no aplicable';
    }
    profilePicUrl = await getProfilePicUrl();
    if (profilePicUrl == null && displayName == 'Ajolote anónimo') {
      profilePic = const AssetImage('img/icon-full-new.png');
    } else if (profilePicUrl != null) {
      profilePic = CachedNetworkImageProvider(profilePicUrl);
    } else {
      profilePic = null;
    }
    notifyListeners();
  }

  Future<void> init() async {
    loading = true;
    notifyListeners();
    firebaseApp = await Firebase.initializeApp();
    await cacheUserAccount();
    loading = false;
    notifyListeners();
  }

  void logOut() async {
    try {
      if (FacebookAuth.instance.accessToken != null) {
        FacebookAuth.instance.logOut();
      }
    } catch (e) {}
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseAuth.instance.signOut();
      }
    } catch (e) {}
    await cacheUserAccount();
  }

  static UserAccount get instance {
    _instance ??= UserAccount();
    return _instance;
  }
}
