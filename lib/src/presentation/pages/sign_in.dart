import 'package:flutter/material.dart';

import '../../config/themes/app_theme.dart';
import '../utils/constants/app_constants.dart';
import '../utils/constants/file_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/social_login_method.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 36),
                  child:
                      Text('Miyotl', style: AppTheme.bigTitleStyle(context))),
              Padding(
                  padding: EdgeInsets.only(bottom: 26),
                  child: Image.asset(FileConstants.icMiyotl,
                      width: SizeConstants.signInLogoSize)),
              SocialButton(
                onPressed: () {
                  initiateSocialLogin(context, AppConstants.googleProvider);
                },
                providerName: FileConstants.icGoogle,
                buttonColor: AppTheme.whiteColor,
                buttonText: "Login with Google",
                buttonTextColor: AppTheme.facebookBlue,
                height: SizeConstants.socialButtonSize,
              ),
              SocialButton(
                onPressed: () {
                  initiateSocialLogin(context, AppConstants.facebookProvider);
                },
                providerName: FileConstants.icFacebook,
                buttonColor: AppTheme.facebookBlue,
                buttonText: "Login with Facebook",
                buttonTextColor: AppTheme.whiteColor,
                height: SizeConstants.socialButtonSize,
              ),
              SocialButton(
                onPressed: () {
                  initiateSocialLogin(context, AppConstants.facebookProvider);
                },
                providerName: FileConstants.icEmail,
                buttonColor: AppTheme.facebookBlue,
                buttonText: "Login with Email",
                buttonTextColor: AppTheme.whiteColor,
                height: SizeConstants.socialButtonSize,
              ),
              Settings().privacy(context, TextAlign.center,
                  EdgeInsets.only(left: 16, top: 30, bottom: 40, right: 16))
            ],
          ),
        ));
  }
}
