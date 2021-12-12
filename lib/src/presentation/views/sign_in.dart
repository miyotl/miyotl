// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lenguas/src/core/utils/constants.dart';
// import 'package:lenguas/src/presentation/views/onboarding.dart';
// import 'package:lenguas/src/presentation/widgets/status_bar_colors.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'models/app_state.dart';
// import 'models/sign_in.dart';
//
// class SignInPage extends StatelessWidget {
//   final VoidCallback onSignIn;
//
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//
//   SignInPage({@required this.onSignIn});
//
//   void doSignIn(BuildContext context, SignInFunction signInFunction) async {
//     /// Log out first
//     try {
//       UserAccount.instance.logOut();
//     } catch (e) {
//       /// Don't do anything on exception, continue sign in
//     }
//     try {
//       var credential = await signInFunction();
//       if (credential == null) {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text(
//               'Cancelaste el inicio de sesión',
//             ),
//             content: Text(
//               'No especificaste ninguna cuenta para iniciar sesión; vuelve a intentarlo.',
//             ),
//             actions: [
//               TextButton(
//                 child: Text('De acuerdo'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       } else {
//         await UserAccount.instance.cacheUserAccount();
//         onSignIn();
//       }
//     } on PlatformException catch (e) {
//       switch (e.code) {
//         case 'sign_in_failed':
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('Inicio de sesión fallido'),
//               content: Text(
//                 'Falló el inicio de sesión. Intenta otra vez, o utiliza otra de las opciones para iniciar sesión.',
//               ),
//               actions: [
//                 TextButton(
//                   child: Text('De acuerdo'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           );
//           break;
//         case 'api-not-available':
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('No tienes servicios de Google'),
//               content: Text(
//                 'Tu teléfono no cuenta con los servicios de Google, por lo que no puedes utilizar este método de inicio de sesión. Selecciona Facebook para poder iniciar sesión.',
//               ),
//             ),
//           );
//           break;
//         default:
//           rethrow;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: dark_theme,
//       child: DarkStatusBar(
//         child: Container(
//           color: AppColors.darkBlue,
//           alignment: Alignment.center,
//           child: SafeArea(
//             child: FutureBuilder<FirebaseApp>(
//               future: _initialization,
//               builder: (context, snapshot) {
//                 if (snapshot.hasError ||
//                     snapshot.connectionState == ConnectionState.done) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: SizedBox(
//                           width: MediaQuery.of(context).size.width * 1.75,
//                           child: Column(
//                             children: [
//                               Text(
//                                 'Inicia sesión o crea una cuenta',
//                                 style: GoogleFonts.fredokaOne().copyWith(
//                                   fontSize: 32,
//                                   color: Colors.white,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               SizedBox(
//                                 height: 8,
//                               ),
//                               RichText(
//                                 text: TextSpan(
//                                   style: Theme.of(context).textTheme.caption,
//                                   children: [
//                                     TextSpan(
//                                       text: 'Al iniciar sesión aceptas ',
//                                     ),
//
//                                     /// https://stackoverflow.com/questions/43583411/how-to-create-a-hyperlink-in-flutter-widget
//                                     TextSpan(
//                                       text:
//                                           'nuestros términos y condiciones y política de privacidad',
//                                       style: TextStyle(
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       recognizer: TapGestureRecognizer()
//                                         ..onTap = () => launch(
//                                               'https://proyecto-miyotl.web.app/privacidad/',
//                                               forceWebView: true,
//                                             ),
//                                     ),
//                                     TextSpan(
//                                         text:
//                                             ', y aceptas recibir correos electrónicos con actualizaciones sobre el proyecto.'),
//                                   ],
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: SignInButton(
//                             Buttons.Google,
//                             text: 'Inicia sesión con Google',
//                             onPressed: () =>
//                                 doSignIn(context, SignInMethods.google),
//                           )),
//                       Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: SignInButton(
//                             Buttons.Facebook,
//                             text: 'Inicia sesión con Facebook',
//                             onPressed: () =>
//                                 doSignIn(context, SignInMethods.facebook),
//                           )),
//                       SignInButtonBuilder(
//                         text: 'Ingresa como invitado',
//                         icon: Icons.face,
//                         backgroundColor: AppColors.darkBlue,
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                               title: Text('Pregunta'),
//                               content: Text(
//                                   '¿Estás seguro que quieres iniciar sesión como invitado? No podremos enviarte correos con actualizaciones sobre el proyecto.'),
//                               actions: [
//                                 TextButton(
//                                   child: Text('Sí, estoy seguro'),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                     doSignIn(context, SignInMethods.anonymous);
//                                   },
//                                 ),
//                                 TextButton(
//                                   child: Text('No, prefiero iniciar sesión'),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   );
//                 }
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
