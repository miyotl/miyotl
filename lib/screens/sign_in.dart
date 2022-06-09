// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miyotl/models/constants.dart';
import 'package:miyotl/models/sign_in.dart';
import 'package:miyotl/models/user_account.dart';
import 'package:miyotl/screens/onboarding.dart';
import 'package:miyotl/widgets/status_bar_colors.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sentry/sentry.dart';

class SignInPage extends StatelessWidget {
  final VoidCallback onSignIn;

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  SignInPage({Key key, @required this.onSignIn}) : super(key: key);

  void doSignIn(BuildContext context, SignInFunction signInFunction) async {
    /// Log out first
    try {
      UserAccount.instance.logOut();
    } catch (e) {
      /// Don't do anything on exception, continue sign in
    }
    try {
      var credential = await signInFunction();
      if (credential == null) {
        showPlatformDialog(
          context: context,
          builder: (context) => PlatformAlertDialog(
            title: const Text(
              'Cancelaste el inicio de sesión',
            ),
            content: const Text(
              'No especificaste ninguna cuenta para iniciar sesión; vuelve a intentarlo.',
            ),
            actions: [
              PlatformDialogAction(
                child: const Text('De acuerdo'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } else {
        await UserAccount.instance.cacheUserAccount();
        onSignIn();
      }
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'sign_in_failed':
          showPlatformDialog(
            context: context,
            builder: (context) => PlatformAlertDialog(
              title: const Text('Inicio de sesión fallido'),
              content: const Text(
                'Falló el inicio de sesión. Intenta otra vez, o utiliza otra de las opciones para iniciar sesión.',
              ),
              actions: [
                PlatformDialogAction(
                  child: const Text('De acuerdo'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
          break;
        case 'api-not-available':
          showPlatformDialog(
            context: context,
            builder: (context) => PlatformAlertDialog(
              title: const Text('No tienes servicios de Google'),
              content: const Text(
                'Tu teléfono no cuenta con los servicios de Google, por lo que no puedes utilizar este método de inicio de sesión. Selecciona Facebook para poder iniciar sesión.',
              ),
            ),
          );
          break;
        default:
          showPlatformDialog(
            context: context,
            builder: (context) => PlatformAlertDialog(
              title: Text(e.code),
              content: Text(e.message),
            ),
          );
          rethrow;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {

        /// TODO: link accounts.
        case 'account-exists-with-different-credential':
          // Pretend nothing happened
          await UserAccount.instance.cacheUserAccount();
          onSignIn();
          break;
        default:
          rethrow;
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      switch (e.code) {
        case AuthorizationErrorCode.canceled:
          showPlatformDialog(
            context: context,
            builder: (context) => PlatformAlertDialog(
              title: const Text(
                'Cancelaste el inicio de sesión de Apple',
              ),
              content: const Text(
                'No especificaste ninguna cuenta para iniciar sesión; vuelve a intentarlo.',
              ),
              actions: [
                PlatformDialogAction(
                  child: const Text('De acuerdo'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
          break;

        // TODO: handle the rest of cases?
        default:
          rethrow;
      }
    } on Exception catch (e, stackTrace) {
      showPlatformDialog(
        context: context,
        builder: (context) => PlatformAlertDialog(
          title: const Text('Error desconocido'),
          content: Text(e.toString()),
          actions: [
            PlatformDialogAction(
              child: const Text('Reportar error'),
              onPressed: () {
                launchUrl(
                  Uri.parse(
                      'mailto:miyotl@googlegroups.com?subject=Error al iniciar sesión&body=$e'),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

      /// TODO: double reporting?
      Sentry.captureException(e, stackTrace: stackTrace);
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1.75,
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
                              const SizedBox(
                                height: 8,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.caption,
                                  children: [
                                    const TextSpan(
                                      text: 'Al iniciar sesión aceptas ',
                                    ),

                                    /// https://stackoverflow.com/questions/43583411/how-to-create-a-hyperlink-in-flutter-widget
                                    TextSpan(
                                      text:
                                          'nuestros términos y condiciones y política de privacidad',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => launchUrl(
                                              Uri.parse(
                                                  'https://proyecto-miyotl.web.app/privacidad/'),
                                              mode: LaunchMode.inAppWebView,
                                            ),
                                    ),
                                    const TextSpan(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SignInButton(
                          Buttons.Apple,
                          text: 'Inicia sesión con Apple',
                          onPressed: () =>
                              doSignIn(context, SignInMethods.apple),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SignInButton(
                          Buttons.Google,
                          text: 'Inicia sesión con Google',
                          onPressed: () =>
                              doSignIn(context, SignInMethods.google),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SignInButton(
                          Buttons.Facebook,
                          text: 'Inicia sesión con Facebook',
                          onPressed: () =>
                              doSignIn(context, SignInMethods.facebook),
                        ),
                      ),
                      SignInButtonBuilder(
                        text: 'Ingresa como invitado',
                        icon: Icons.face,
                        backgroundColor: AppColors.darkBlue,
                        onPressed: () {
                          showPlatformDialog(
                            context: context,
                            builder: (context) => PlatformAlertDialog(
                              title: const Text('Pregunta'),
                              content: const Text(
                                  '¿Estás seguro que quieres iniciar sesión como invitado? No podremos enviarte correos con actualizaciones sobre el proyecto.'),
                              actions: [
                                PlatformDialogAction(
                                  child: const Text('Sí, estoy seguro'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    doSignIn(context, SignInMethods.anonymous);
                                  },
                                ),
                                PlatformDialogAction(
                                  child:
                                      const Text('No, prefiero iniciar sesión'),
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
                return const Center(
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
