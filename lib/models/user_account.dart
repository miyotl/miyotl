import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';

class UserAccount {
  static String displayName;
  static String email;
  static String profilePicUrl;
  static ImageProvider profilePic;

  static Future<String> _getDisplayName() async {
    var isLogged = await FacebookAuth.instance.isLogged;
    if (isLogged == null) {
      return FirebaseAuth.instance?.currentUser?.displayName ??
          'Ajolote anónimo';
    } else {
      var userData = await FacebookAuth.instance.getUserData();
      return userData['name'] ?? '<error al obtener tu nombre>';
    }
  }

  static Future<String> _getEmail() async {
    var isLogged = await FacebookAuth.instance.isLogged;
    if (isLogged == null) {
      return FirebaseAuth.instance.currentUser?.email ?? 'Correo no aplicable';
    } else {
      var userData = await FacebookAuth.instance.getUserData();
      return userData['email'];
    }
  }

  static Future<String> _getProfilePicUrl() async {
    var isLogged = await FacebookAuth.instance.isLogged;
    if (isLogged == null) {
      return FirebaseAuth.instance.currentUser?.photoURL;
    } else {
      var userData = await FacebookAuth.instance.getUserData();
      return userData['picture']['data']['url'];
    }
  }

  static Future<void> cacheUserAccount() async {
    displayName = await _getDisplayName();
    email = await _getEmail();
    profilePicUrl = await _getProfilePicUrl();
    if (profilePicUrl == null) {
      profilePic = AssetImage('img/icon-full-new.png');
    } else {
      profilePic = CachedNetworkImageProvider(profilePicUrl);
    }
  }
}
