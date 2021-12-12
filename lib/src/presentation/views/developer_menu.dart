// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lenguas/src/core/utils/constants.dart';
// import 'package:provider/provider.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'debug/string_viewer.dart';
// import 'models/app_state.dart';
//
// class DeveloperPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Diagnósticos',
//           style: GoogleFonts.fredokaOne(),
//         ),
//       ),
//       body: ListView(
//         children: [
//           ElevatedButton(
//             child: Text('Consultar disponibilidad de servicios de Google'),
//             onPressed: () {
//               analytics.logEvent(
//                 name: 'developer-option',
//                 parameters: {'option': 'google-availability'},
//               );
//               Navigator.of(context).pushNamed('/debug/google');
//             },
//           ),
//           ElevatedButton(
//             child: Text('Abrir pantalla inicial'),
//             onPressed: () {
//               analytics.logEvent(
//                 name: 'developer-option',
//                 parameters: {'option': 'open-onboarding'},
//               );
//               Navigator.of(context).pushNamed('/onboarding');
//             },
//           ),
//           ElevatedButton(
//             child: Text('Abrir pantalla inicial después del próximo reinicio'),
//             onPressed: () {
//               analytics.logEvent(
//                 name: 'developer-option',
//                 parameters: {'option': 'revert-onboarding'},
//               );
//               AppState state = Provider.of<AppState>(context, listen: false);
//               state.setOnboardingStatus(false);
//             },
//           ),
//           ElevatedButton(
//             child: Text('Ver base de datos'),
//             onPressed: () {
//               analytics.logEvent(
//                 name: 'developer-option',
//                 parameters: {'option': 'view-data'},
//               );
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => JsonViewerPage(
//                     title: 'Base de datos',
//                     json: Provider.of<AppState>(context, listen: false).data,
//                   ),
//                 ),
//               );
//             },
//           ),
//           ElevatedButton(
//             child: Text('Ver archivo de base de datos'),
//             onPressed: () {
//               analytics.logEvent(
//                 name: 'developer-option',
//                 parameters: {'option': 'view-data-file'},
//               );
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => AsyncStringViewerPage(
//                     title: 'Base de datos (archivo)',
//                     string: Provider.of<AppState>(context, listen: false)
//                         .loadLanguageDataFromDisk(),
//                   ),
//                 ),
//               );
//             },
//           ),
//           ElevatedButton(
//             child: Text('Ver detalles de cuenta'),
//             onPressed: () {
//               analytics.logEvent(
//                 name: 'developer-option',
//                 parameters: {'option': 'view-account'},
//               );
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => AsyncStringViewerPage(
//                     title: 'Detalles de cuenta',
//                     string: UserAccount.instance.getDebugAccountDetails(),
//                   ),
//                 ),
//               );
//             },
//           ),
//           ElevatedButton(
//             child: Text('Olvidarse de que la base de datos está actualizada'),
//             onPressed: () async {
//               analytics.logEvent(
//                 name: 'developer-option',
//                 parameters: {'option': 'forget-data'},
//               );
//               final prefs = await SharedPreferences.getInstance();
//               prefs.setInt('last-update', 2001010101);
//             },
//           ),
//           ElevatedButton(
//             child: Text('Hacer un error falso'),
//             onPressed: () async {
//               analytics.logEvent(
//                 name: 'developer-option',
//                 parameters: {'option': 'test-exception'},
//               );
//               try {
//                 throw Exception('Test exception');
//               } catch (exception, stackTrace) {
//                 await Sentry.captureException(exception,
//                     stackTrace: stackTrace);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
