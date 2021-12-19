import 'package:flutter/material.dart';
import 'package:lenguas/src/presentation/widgets/settings.dart';

import '../../config/themes/app_theme.dart';
import '../utils/constants/app_constants.dart';
import '../utils/constants/file_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/social_login_method.dart';
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
              SocialButton(
                onPressed: () {
                  initiateSocialLogin(context, AppConstants.googleProvider);
                },
                providerName: FileConstants.icGoogle,
                buttonColor: AppTheme.whiteColor,
                buttonText: 'Google',
                buttonTextColor: AppTheme.facebookBlue,
                height: SizeConstants.socialButtonSize,
              ),
              SocialButton(
                onPressed: () {
                  initiateSocialLogin(context, AppConstants.facebookProvider);
                },
                providerName: FileConstants.icFacebook,
                buttonColor: AppTheme.facebookBlue,
                buttonText: 'Facebook',
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
