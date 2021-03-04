import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenguas/models/constants.dart';
import 'package:lenguas/models/sign_in.dart';
import 'package:lenguas/models/user_account.dart';
import 'package:lenguas/screens/onboarding.dart';
import 'package:lenguas/widgets/status_bar_colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatelessWidget {
  final VoidCallback onSignIn;

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  SignInPage({@required this.onSignIn});

  void doSignIn(BuildContext context, SignInFunction signInFunction) async {
    /// Log out first
    try {
      if (FacebookAuth.instance.isLogged != null) {
        FacebookAuth.instance.logOut();
      }
      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseAuth.instance.signOut();
      }
    } catch (e) {
      /// Don't do anything on exception, continue sign in
    }
    try {
      var credential = await signInFunction();
      AccessToken isLogged;
      try {
        isLogged = await FacebookAuth.instance.isLogged;
      } catch (e) {
        isLogged = null;
      }
      if (signInFunction != SignInMethods.anonymous &&
          credential == null &&
          isLogged == null) {
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
        var account = Provider.of<UserAccount>(context, listen: false);
        await account.cacheUserAccount();
        onSignIn();
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
    return Theme(
      data: dark_theme,
      child: DarkStatusBar(
        child: Container(
          color: AppColors.darkBlue,
          alignment: Alignment.center,
          child: SafeArea(
            child: FutureBuilder<FirebaseApp>(
              future: _initialization,
              builder: (context, snapshot) {
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.done) {
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
                                  style: Theme.of(context).textTheme.caption,
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
                                    doSignIn(context, SignInMethods.anonymous);
                                  },
                                ),
                                TextButton(
                                  child: Text('No, déjame iniciar sesión...'),
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
    );
  }
}
