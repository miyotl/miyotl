import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart';
import 'package:lenguas/models/constants.dart';
import 'dart:convert';

abstract class SignInMethods {
  /// Social sign ins methods from https://firebase.flutter.dev/docs/auth/social/

  static Future<UserCredential> google() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<UserCredential> facebook() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    try {
      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    } catch (e) {
      /// On exception, return null (for instance on Huawei phones)
      var userData = await FacebookAuth.instance.getUserData();
      var response = await post(
        facebook_huawei_form_url,
        body: {
          'entry.1617036946': json.encode(userData),
        },
      );
      if (response.statusCode != 200) {
        throw Exception(
            'El formulario no se envió exitosamente, dio error ${response.statusCode}');
      }
      return null;
    }
  }

  static Future<UserCredential> anonymous() async {
    return await FirebaseAuth.instance.signInAnonymously();
  }
}
