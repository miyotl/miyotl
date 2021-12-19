import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../model/res_google_signin_model.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/constants/key_constants.dart';
import '../../utils/log_utils.dart';
import '../../widgets/progress_dialog.dart';

part 'sign_in_bloc.freezed.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState());

  @override
  void onEvent(SignInEvent event) {
    super.onEvent(event);
  }

  //Google SignIn Process
  void _googleSignInProcess(BuildContext context) async {
    var _googleSignIn = GoogleSignIn();
    var googleUser = await _googleSignIn.signIn();
    var googleAuth = await googleUser?.authentication;
    var token = googleAuth?.idToken;
    var _socialGoogleUser = ResGoogleSignInModel(
        displayName: googleUser?.displayName,
        email: googleUser?.email,
        photoUrl: googleUser?.photoUrl,
        id: googleUser?.id,
        token: token);
    Fluttertoast.showToast(
        msg: googleUser!.email,
        backgroundColor: Colors.blue,
        textColor: Colors.white);
    LogUtils.showLog("${_socialGoogleUser.toJson()}");
  }

//Facebook SignIn Process
  void _facebookSignInProcess(BuildContext context) async {
    var result = await FacebookAuth.instance.login();
    ProgressDialogUtils.showProgressDialog(context);
    if (result.status == LoginStatus.success) {
      var accessToken = result.accessToken!;
      var userData = await FacebookAuth.i.getUserData(
        fields: KeyConstants.facebookUserDataFields,
      );
      ProgressDialogUtils.dismissProgressDialog();
      Fluttertoast.showToast(
          msg: userData[KeyConstants.emailKey],
          backgroundColor: Colors.blue,
          textColor: Colors.white);
      LogUtils.showLog("${accessToken.userId}");
      LogUtils.showLog("$userData");
    } else {
      ProgressDialogUtils.dismissProgressDialog();
      _showFailureResult(result);
    }
  }

//Combine Social Authentication
  Future initiateSocialLogin(BuildContext context, String provider) async {
    try {
      if (provider == AppConstants.googleProvider) {
        _googleSignInProcess(context);
      } else if (provider == AppConstants.facebookProvider) {
        _facebookSignInProcess(context);
      }
    } on Exception catch (e) {
      LogUtils.showLog("$e");
    }
  }

//Combine Social Logout
  Future initiateSocialLogout(BuildContext context, String provider) async {
    try {
      if (provider == AppConstants.googleProvider) {
        GoogleSignIn().signOut();
      } else {
        await FacebookAuth.instance.logOut();
      }
    } on Exception catch (e) {
      LogUtils.showLog("$e");
    }
  }

//Common Failure Result Method
  void _showFailureResult(LoginResult authResult) {
    ProgressDialogUtils.dismissProgressDialog();
    LogUtils.showLog("${authResult.status}");
    Fluttertoast.showToast(
        msg: authResult.status.toString(),
        backgroundColor: Colors.blue,
        textColor: Colors.white);
  }
}

// used to define how to display the values for the dictionary
enum LookupMode { originalLanguage, targetLanguage }