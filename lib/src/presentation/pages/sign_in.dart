import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenguas/src/domain/entities/user_auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/routes/app_routes.dart';
import '../../config/themes/app_theme.dart';
import '../blocs/signin/sign_in_bloc.dart';
import '../utils/constants/app_constants.dart';
import '../utils/constants/file_constants.dart';
import '../utils/constants/size_constants.dart';
import '../widgets/settings.dart';
import '../widgets/social_button.dart';

// https://medium.com/flutter-community/social-authentication-in-customized-flutter-applications-5c972bff17f3
class SocialSignInScreen extends StatefulWidget {
  @override
  State createState() => SocialSignInScreenState();
}

class SocialSignInScreenState extends State<SocialSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBlue,
      body: SafeArea(
          child: BlocListener<SignInBloc, SignInState>(
              listener: (context, state) => {
                    if (state.userLoggedIn)
                      {_saveUserData(state.userData), _onSignInSuccess(context)}
                  },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 36),
                      child: Text(AppConstants.app_name,
                          style: AppTheme.bigTitleStyle(context))),
                  Padding(
                      padding: EdgeInsets.only(bottom: 26),
                      child: Image.asset(FileConstants.icMiyotl,
                          width: SizeConstants.signInLogoSize)),
                  SocialButton(
                    onPressed: () {
                      context.read<SignInBloc>().add(
                          SignInEvent.signInWithProvider(
                              provider: AppConstants.googleProvider));
                    },
                    providerName: FileConstants.icGoogle,
                    buttonColor: AppTheme.whiteColor,
                    buttonText: AppConstants.googleProvider,
                    buttonTextColor: AppTheme.facebookBlue,
                    height: SizeConstants.socialButtonSize,
                  ),
                  SocialButton(
                    onPressed: () {
                      context.read<SignInBloc>().add(
                          SignInEvent.signInWithProvider(
                              provider: AppConstants.facebookProvider));
                    },
                    providerName: FileConstants.icFacebook,
                    buttonColor: AppTheme.facebookBlue,
                    buttonText: AppConstants.loginWithFacebook,
                    buttonTextColor: AppTheme.whiteColor,
                    height: SizeConstants.socialButtonSize,
                  ),
                  Settings().privacy(context, TextAlign.center,
                      EdgeInsets.only(left: 16, top: 30, bottom: 31, right: 16))
                ],
              ))),
    );
  }

  void _onSignInSuccess(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.home);
  }

  Future<void> _saveUserData(UserAuthModel? userData) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = (prefs.getBool(AppConstants.isUserLoggedInKey) ?? false);
    if (userData?.token != null) {
      setState(() {
        prefs.setString(AppConstants.userProfileKey, userData?.toString() ?? '');
        prefs.setBool(AppConstants.isUserLoggedInKey, true).then((success) {
          return isLoggedIn;
        });
      });
    }
  }
}
