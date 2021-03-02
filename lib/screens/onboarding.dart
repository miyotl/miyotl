import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lenguas/models/app_state.dart';
import 'package:lenguas/screens/home.dart';
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

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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

  void doSignIn(BuildContext context, SignInFunction signInFunction) async {
    try {
      var credential = await signInFunction();
      var isLogged = await FacebookAuth.instance.isLogged;
      if (credential == null && isLogged == null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Cancelaste el inicio de sesión',
            ),
            content: Text(
              'No especificaste ninguna cuenta para iniciar sesión; vuelve a intentarlo.',
            ),
            actions: [
              TextButton(
                child: Text('De acuerdo'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } else {
        AppState state = Provider.of<AppState>(
          context,
          listen: false,
        );
        UserAccount.displayName.then((name) => setState(() => _name = name));
        state.firebaseCredential = credential;
        nextPage();
      }
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'sign_in_failed':
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Inicio de sesión fallido'),
              content: Text(
                'Falló el inicio de sesión. Intenta otra vez, o utiliza otra de las opciones para iniciar sesión.',
              ),
              actions: [
                TextButton(
                  child: Text('De acuerdo'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
          break;
        case 'api-not-available':
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('No tienes servicios de Google'),
              content: Text(
                'Tu teléfono no cuenta con los servicios de Google, por lo que no puedes utilizar este método de inicio de sesión. Selecciona Facebook para poder iniciar sesión.',
              ),
            ),
          );
          break;
        default:
          rethrow;
      }
    } on FacebookAuthException catch (e) {
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          break;
        case FacebookAuthErrorCode.CANCELLED:
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Cancelaste el inicio de sesión'),
              content: Text(
                'Vuelve a intentar iniciar sesión, o selecciona otro método de inicio de sesión',
              ),
              actions: [
                TextButton(
                  child: Text('De acuerdo'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
          break;
        default:
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Falló el inicio de sesión con Facebook'),
              content: Text(
                'Error ${e.errorCode}: ${e.message}.\nPor favor toma captura de pantalla y mándala a miyotl@googlegroups.com.',
              ),
            ),
          );
      }
    } catch (e) {
      /// TODO: report errors in a more automatic way
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error desconocido'),
          content: Text(
            'Ocurrió un error desconocido. Por favor toma captura de pantalla y mándala a miyotl@googlegroups.com.\n\nEl error es:\n\n$e',
          ),
        ),
      );
    }
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

          Theme(
            data: dark_theme,
            child: DarkStatusBar(
              child: Container(
                color: AppColors.darkBlue,
                alignment: Alignment.center,
                child: SafeArea(
                  child: FutureBuilder<FirebaseApp>(
                    future: _initialization,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return EmptyState('${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Column(
                                  children: [
                                    Text(
                                      'Inicia sesión o crea una cuenta',
                                      style: GoogleFonts.fredokaOne().copyWith(
                                        fontSize: 32,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        children: [
                                          TextSpan(
                                            text: 'Al iniciar sesión aceptas ',
                                          ),

                                          /// https://stackoverflow.com/questions/43583411/how-to-create-a-hyperlink-in-flutter-widget
                                          TextSpan(
                                            text:
                                                'nuestros términos y condiciones y política de privacidad',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => launch(
                                                    'https://proyecto-miyotl.web.app/privacidad/',
                                                    forceWebView: true,
                                                  ),
                                          ),
                                          TextSpan(
                                              text:
                                                  ', y aceptas recibir correos electrónicos con actualizaciones sobre el proyecto.'),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (googleServicesAvailability !=
                                GooglePlayServicesAvailability.serviceMissing)
                              SignInButton(
                                Buttons.Google,
                                text: 'Inicia sesión con Google',
                                onPressed: () =>
                                    doSignIn(context, SignInMethods.google),
                              ),
                            // SignInButton(
                            //   Buttons.Email,
                            //   text: 'Con correo y contraseña',
                            //   onPressed: () {
                            //     Scaffold.of(context).showSnackBar(
                            //       SnackBar(
                            //         content:
                            //             Text('Funcionalidad no implementada'),
                            //       ),
                            //     );
                            //   },
                            // ),
                            SignInButton(
                              Buttons.Facebook,
                              text: 'Inicia sesión con Facebook',
                              onPressed: () =>
                                  doSignIn(context, SignInMethods.facebook),
                            ),
                            // SignInButton(
                            //   Buttons.AppleDark,
                            //   text: 'Inicia sesión con Apple',
                            //   onPressed: () {
                            //     Scaffold.of(context).showSnackBar(
                            //       SnackBar(
                            //         content:
                            //             Text('Funcionalidad no implementada'),
                            //       ),
                            //     );
                            //   },
                            // ),
                            if (googleServicesAvailability !=
                                GooglePlayServicesAvailability.serviceMissing)
                              SignInButtonBuilder(
                                text: 'Ingresa como invitado',
                                icon: Icons.face,
                                backgroundColor: AppColors.darkBlue,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Pregunta'),
                                      content: Text(
                                          '¿Estás seguro que quieres iniciar sesión como invitado? No podremos enviarte correos con actualizaciones sobre el proyecto...'),
                                      actions: [
                                        TextButton(
                                          child: Text('Sí, estoy seguro'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            doSignIn(context,
                                                SignInMethods.anonymous);
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                              'No, déjame iniciar sesión...'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          /// PAGE 3
          /// Language select

          DarkStatusBar(
            child: Container(
              color: AppColors.morado,
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Hola, $_name.',
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                      ),
                    ),
                    Text(
                      '¿Qué idioma quieres aprender?',
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                    ),
                    Expanded(
                      child: Consumer<AppState>(
                        builder: (context, state, child) {
                          return ListView(
                            padding: EdgeInsets.all(8),
                            shrinkWrap: true,
                            children: [
                              for (var language in state.languages)
                                Card(
                                  child: ListTile(
                                    title: Text('${language.name}'),
                                    subtitle:
                                        Text('${language.speakers} hablantes'),
                                    leading: Icon(Icons.language),
                                    onTap: () {
                                      /// Save onboarding finished and language
                                      state.changeLanguage(language.name);
                                      state.setOnboardingStatus(true);
                                      state.setDefaultLanguage(state.language);
                                      nextPage();
                                    },
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
