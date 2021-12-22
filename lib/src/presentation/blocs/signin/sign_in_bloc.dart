import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/user_auth_model.dart';
import '../../../domain/usecases/is_user_logged_in_usecase.dart';
import '../../../domain/usecases/read_user_auth_usecase.dart';
import '../../../domain/usecases/store_user_auth_usecase.dart';
import '../../model/SignInResult.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/constants/key_constants.dart';
import '../../utils/log_utils.dart';
import '../../widgets/progress_dialog.dart';

part 'sign_in_bloc.freezed.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._isUserLoggedInUseCase, this._storeUserAuthUseCase,
      this._readUserAuthUseCase)
      : super(SignInState.loginResult());

  final IsUserLoggedInUseCase _isUserLoggedInUseCase;
  final StoreUserAuthUseCase _storeUserAuthUseCase;
  final ReadUserAuthUseCase _readUserAuthUseCase;

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    switch (event.provider) {
      case AppConstants.facebookProvider:
        var result = await _facebookSignInProcess();
        _storeUserData(result.data);
        yield state.copyWith(userLoggedIn: result.success);
        break;
      case AppConstants.googleProvider:
        var result = await _googleSignInProcess();
        _storeUserData(result.data);
        yield state.copyWith(userLoggedIn: result.success);
        break;
    }
  }

  Future<void> _storeUserData(UserAuthModel? data) async {
    if (data?.token != null) {
      await _storeUserAuthUseCase(data!);
    }
  }

//Google SignIn Process
  Future<SignInResult> _googleSignInProcess() async {
    var _googleSignIn = GoogleSignIn();
    var googleUser = await _googleSignIn.signIn();
    var googleAuth = await googleUser?.authentication;
    var token = googleAuth?.idToken;
    var _socialGoogleUser = UserAuthModel(
        displayName: googleUser?.displayName,
        email: googleUser?.email,
        photoUrl: googleUser?.photoUrl,
        id: googleUser?.id,
        token: token);
    return SignInResult(success: token != null, data: _socialGoogleUser);
  }

//Facebook SignIn Process
  Future<SignInResult> _facebookSignInProcess() async {
    var result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      var accessToken = result.accessToken!;
      var userData = await FacebookAuth.i.getUserData(
        fields: KeyConstants.facebookUserDataFields,
      );
      Fluttertoast.showToast(
          msg: userData[KeyConstants.emailKey],
          backgroundColor: Colors.blue,
          textColor: Colors.white);
      LogUtils.showLog("${accessToken.userId}");
      LogUtils.showLog("$userData");
      return SignInResult(
          success: true, data: mapToAuthModel(userData, accessToken));
    } else {
      _showFailureResult(result);
      return SignInResult(success: false);
    }
  }

  UserAuthModel mapToAuthModel(
      Map<String, dynamic> userData, AccessToken accessToken) {
    return UserAuthModel(
        displayName: userData[KeyConstants.nameKey],
        email: userData[KeyConstants.emailKey],
        id: accessToken.userId,
        photoUrl: userData[KeyConstants.pictureKey],
        token: accessToken.toString());
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
