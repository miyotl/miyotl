import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lenguas/models/app_state.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../widgets/empty_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../models/constants.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  LiquidController controller;

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    controller = LiquidController();
    super.initState();
  }

  void nextPage() {
    controller.animateToPage(page: controller.currentPage + 1);
  }

  Future<UserCredential> signInWithGoogle() async {
    /// https://firebase.flutter.dev/docs/auth/social/#google

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

  Future<UserCredential> signInWithFacebook() async {
    /*/// https://firebase.flutter.dev/docs/auth/social/

    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);*/

    return await FirebaseAuth.instance.signInAnonymously();
  }

  Function doGoogleSignIn(BuildContext context) {
    return () async {
      try {
        var credential = await signInWithGoogle();
        if (credential == null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Cancelaste el inicio de sesión',
              ),
              content: Text(
                'No especificaste ninguna cuenta de Google para iniciar sesión; vuelve a intentarlo.',
              ),
              actions: [
                FlatButton(
                  child: Text('DE ACUERDO'),
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
          state.firebaseCredential = credential;
          nextPage();
        }
      } catch (e) {
        if (e is PlatformException && e.code == 'sign_in_failed') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Inicio de sesión fallido'),
              content: Text(
                'Falló el inicio de sesión. Intenta otra vez, o utiliza otra de las opciones para iniciar sesión.',
              ),
              actions: [
                FlatButton(
                  child: Text('DE ACUERDO'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        } else {
          /// TODO: report errors in a more automatic way
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error desconocido'),
              content: Text(
                  'Ocurrió un error desconocido. Por favor toma captura de pantalla y reporta con los desarrolladores.\n\nEl error es:\n\n$e'),
            ),
          );
        }
      }
    };
  }

  // Copy-paste in case more changes are needed :P
  Function doFacebookSignIn(BuildContext context) {
    return () async {
      try {
        var credential = await signInWithFacebook();
        if (credential == null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Cancelaste el inicio de sesión',
              ),
              content: Text(
                'No especificaste ninguna cuenta de Google para iniciar sesión; vuelve a intentarlo.',
              ),
              actions: [
                FlatButton(
                  child: Text('DE ACUERDO'),
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
          state.firebaseCredential = credential;
          nextPage();
        }
      } catch (e) {
        if (e is PlatformException && e.code == 'sign_in_failed') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Inicio de sesión fallido'),
              content: Text(
                'Falló el inicio de sesión. Intenta otra vez, o utiliza otra de las opciones para iniciar sesión.',
              ),
              actions: [
                FlatButton(
                  child: Text('DE ACUERDO'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        } else {
          /// TODO: report errors in a more automatic way
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error desconocido'),
              content: Text(
                  'Ocurrió un error desconocido. Por favor toma captura de pantalla y reporta con los desarrolladores.\n\nEl error es:\n\n$e'),
            ),
          );
        }
      }
    };
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
                    onPressed: nextPage,
                  ),
                ],
              ),
              color: Colors.white,
            ),
          ),

          /// PAGE 2
          /// Sign in screen

          Theme(
            data: dark_theme,
            child: Scaffold(
              body: SafeArea(
                child: Container(
                  alignment: Alignment.center,
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
                                child: Text(
                                  'Inicia sesión o crea una cuenta',
                                  style: GoogleFonts.fredokaOne()
                                      .copyWith(fontSize: 32),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SignInButton(
                              Buttons.GoogleDark,
                              text: 'Inicia sesión con Google',
                              onPressed: doGoogleSignIn(context),
                            ),
                            SignInButton(
                              Buttons.Email,
                              text: 'Con correo y contraseña',
                              onPressed: () {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Funcionalidad no implementada'),
                                  ),
                                );
                              },
                            ),
                            SignInButton(
                              Buttons.Facebook,
                              text: 'Inicia sesión con Facebook',
                              onPressed: doFacebookSignIn(context),
                            ),
                            SignInButton(
                              Buttons.AppleDark,
                              text: 'Inicia sesión con Apple',
                              onPressed: () {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Funcionalidad no implementada'),
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

          Container(
            color: AppColors.morado,
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Column(
                children: [
                  // SizedBox(height: 16),
                  Consumer<AppState>(
                    builder: (context, state, child) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Hola, ${state.givenName}.',
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 32,
                              color: Colors.white,
                            ),
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
                    child: ListView(
                      padding: EdgeInsets.all(8),
                      shrinkWrap: true,
                      children: [
                        Card(
                          child: ListTile(
                            title: Text('Chinanteco'),
                            subtitle: Text('125,726 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Chocholteco'),
                            subtitle: Text('814 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                        Card(
                          child: ListTile(
                              title: Text('Mazateco'),
                              subtitle: Text('230,124 hablantes'),
                              leading: Icon(Icons.language),
                              onTap: () {
                                while (Navigator.of(context).canPop()) {
                                  Navigator.of(context).pop();
                                }
                              }),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Maya'),
                            subtitle: Text('859,607 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Mazahua'),
                            subtitle: Text('151,897 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Mixe'),
                            subtitle: Text('136,736 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Mizteco'),
                            subtitle: Text('496,038 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Náhuatl'),
                            subtitle: Text('1,568,884 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Hña Hñu'),
                            subtitle: Text('307,928 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Tzeltal'),
                            subtitle: Text('476,628 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Tzotzil'),
                            subtitle: Text('417,462 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Zapoteco'),
                            subtitle: Text('460,695 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Tutunaku'),
                            subtitle: Text('250,252 hablantes'),
                            leading: Icon(Icons.language),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
