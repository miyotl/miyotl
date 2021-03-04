import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lenguas/models/app_state.dart';
import 'package:lenguas/screens/home.dart';
import 'package:lenguas/screens/language_select.dart';
import 'package:lenguas/screens/sign_in.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../widgets/empty_state.dart';
import 'package:provider/provider.dart';
import '../models/constants.dart';
import '../models/sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/status_bar_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_api_availability/google_api_availability.dart';

typedef SignInFunction = Future<UserCredential> Function();

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  LiquidController controller;

  String _name;

  GooglePlayServicesAvailability googleServicesAvailability;

  @override
  void initState() {
    controller = LiquidController();
    super.initState();
  }

  void nextPage() {
    controller.animateToPage(page: controller.currentPage + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        enableSlideIcon: false,
        enableLoop: false,
        disableUserGesture: true,
        liquidController: controller,
        pages: [
          /// PAGE 1
          /// Welcome screen

          Theme(
            data: new_light_theme,
            child: LightStatusBar(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'img/icon-round-new-outline.png',
                      width: MediaQuery.of(context).size.width * 0.66,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Miyotl',
                      style: GoogleFonts.fredokaOne().copyWith(
                        fontSize: 64,
                        color: AppColors.azulMorado,
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        'Nuestras lenguas prehispánicas son hoy raíz y vuelo luminoso de unión y paz.',
                        style: GoogleFonts.rubik().copyWith(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      child: Text(
                        'Empieza ahora',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () async {
                        googleServicesAvailability = await GoogleApiAvailability
                            .instance
                            .checkGooglePlayServicesAvailability();
                        print(
                            'Google service availability is $googleServicesAvailability');
                        nextPage();
                      },
                    ),
                  ],
                ),
                color: Colors.white,
              ),
            ),
          ),

          /// PAGE 2
          /// Sign in screen

          SignInPage(
            onSignIn: () {
              setState(() => _name =
                  Provider.of<UserAccount>(context, listen: false).displayName);
              nextPage();
            },
          ),

          /// PAGE 3
          /// Language select

          LanguageSelectPage(
            title:
                'Hola, ${(_name == 'Ajolote anónimo' || _name == null) ? 'Ajolote anónimo' : _name.split(' ')[0]}',
            onLanguageSelect: (language) {
              nextPage();
            },
          ),

          /// PAGE 4
          /// Warm welcome

          Theme(
            data: new_light_theme,
            child: LightStatusBar(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'img/axolotl-hi.png',
                      width: MediaQuery.of(context).size.width * 0.66,
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Text(
                        '${(_name == null || _name == 'Ajolote anónimo') ? '¡Listo!' : 'Listo, ' + _name.split(' ')[0]}',
                        style: GoogleFonts.fredokaOne().copyWith(
                          fontSize: 48,
                          color: AppColors.morado,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        'Esperamos que disfrutes la App :)',
                        style: GoogleFonts.rubik().copyWith(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16),
                    RaisedButton(
                      color: AppColors.morado,
                      child: Text(
                        'Comenzar',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        /// TODO: There is no animation, one would be nice, like a round one
                        Provider.of<AppState>(context, listen: false)
                            .setOnboardingStatus(true);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
