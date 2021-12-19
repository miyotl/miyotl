import 'package:flutter/material.dart';

import '../../config/themes/app_theme.dart';
import '../utils/constants/app_constants.dart';
import '../utils/constants/file_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/social_login_method.dart';
import '../widgets/social_button.dart';

class SocialSignInScreen extends StatefulWidget {
  @override
  State createState() => SocialSignInScreenState();
}

class SocialSignInScreenState extends State<SocialSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppTheme.purpleColor,
        ),
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
                buttonTextColor: AppTheme.purpleColor,
                height: SizeConstants.socialButtonSize,
              ),
              SocialButton(
                onPressed: () {
                  initiateSocialLogin(context, AppConstants.facebookProvider);
                },
                providerName: FileConstants.icFacebook,
                buttonColor: AppTheme.purpleColor,
                buttonText: 'Facebook',
                buttonTextColor: AppTheme.whiteColor,
                height: SizeConstants.socialButtonSize,
              ),
            ],
          ),
        ));
  }
}
