import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lenguas/models/app_state.dart';
import 'package:lenguas/screens/home.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../widgets/empty_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../models/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/status_bar_colors.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

typedef SignInFunction = Future<UserCredential> Function();

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

  Future<UserCredential> signInAnonymously() async {
    return await FirebaseAuth.instance.signInAnonymously();
  }

  Function doSignIn(BuildContext context, SignInFunction signInFunction) {
    return () async {
      try {
        var credential = await signInFunction();
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
                      onPressed: nextPage,
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
                                child: Text(
                                  'Inicia sesión o crea una cuenta',
                                  style: GoogleFonts.fredokaOne().copyWith(
                                    fontSize: 32,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SignInButton(
                              Buttons.GoogleDark,
                              text: 'Inicia sesión con Google',
                              onPressed: doSignIn(context, signInWithGoogle),
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
                            SignInButtonBuilder(
                              text: 'Inicio de sesión anónimo',
                              icon: Icons.face,
                              backgroundColor: AppColors.darkBlue,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Pregunta'),
                                    content: Text(
                                        '¿Estás seguro que quieres iniciar sesión de forma anónima? No podremos enviarte correos con actualizaciones sobre el proyecto...'),
                                    actions: [
                                      TextButton(
                                        child: Text('Sí, estoy seguro'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          doSignIn(
                                              context, signInAnonymously)();
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
                                      state.changeLanguage(language.name);
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                        (route) => false,
                                      );
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
        ],
      ),
    );
  }
}
