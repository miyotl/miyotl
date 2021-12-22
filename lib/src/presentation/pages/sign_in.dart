import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      {
                        _onSignInSuccess(context)
                      }
                  },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 36),
                      child: Text('Miyotl',
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
                    buttonText: "Login with Google",
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
                    buttonText: "Login with Facebook",
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
}
