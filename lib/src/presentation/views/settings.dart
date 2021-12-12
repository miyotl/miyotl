// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// import 'models/app_state.dart';
// // TODO update to better settings
//
// class SettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Ajustes',
//           style: GoogleFonts.fredokaOne(),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(8),
//         child: Consumer2<Settings, UserAccount>(
//           builder: (context, settings, account, child) =>
//           Text("Settings")
//           //     SettingsList(
//           //   backgroundColor: Colors.transparent,
//           //   sections: [
//           //     // SettingsSection(
//           //     //   title: 'Apariencia',
//           //     //   tiles: [
//           //     //     SettingsTile(
//           //     //       title: 'Tema',
//           //     //       subtitle: settings.theme.string(),
//           //     //       leading: Icon(Icons.lightbulb),
//           //     //       onPressed: (BuildContext context) {
//           //     //         showDialog(
//           //     //           context: context,
//           //     //           builder: (context) => SimpleDialog(
//           //     //             title: Text('Tema'),
//           //     //             children: [
//           //     //               for (var value in ThemeMode.values)
//           //     //                 RadioListTile<ThemeMode>(
//           //     //                   title: Text('${value.string()}'),
//           //     //                   value: value,
//           //     //                   groupValue: settings.theme,
//           //     //                   onChanged: (value) {
//           //     //                     settings.theme = value;
//           //     //                     analytics.setUserProperty(
//           //     //                         name: 'theme',
//           //     //                         value: '${settings.theme}');
//           //     //                     Navigator.of(context).pop();
//           //     //                   },
//           //     //                 ),
//           //     //             ],
//           //     //           ),
//           //     //         );
//           //     //       },
//           //     //     ),
//           //     //     SettingsTile(
//           //     //       title: 'Estilo',
//           //     //       subtitle: settings.useIOSStyle ? 'iOS' : 'Android',
//           //     //       leading: Icon(
//           //     //         settings.useIOSStyle
//           //     //             ? Ionicons.logo_apple
//           //     //             : Icons.android,
//           //     //       ),
//           //     //       onPressed: (context) => showDialog(
//           //     //         context: context,
//           //     //         builder: (context) => SimpleDialog(
//           //     //           title: Text('Estilo'),
//           //     //           children: [
//           //     //             RadioListTile<bool>(
//           //     //               title: Text('iOS'),
//           //     //               value: true,
//           //     //               groupValue: settings.useIOSStyle,
//           //     //               onChanged: (value) {
//           //     //                 analytics.setUserProperty(
//           //     //                     name: 'ux', value: 'ios');
//           //     //                 settings.useIOSStyle = value;
//           //     //                 Navigator.of(context).pop();
//           //     //               },
//           //     //             ),
//           //     //             RadioListTile<bool>(
//           //     //               title: Text('Android'),
//           //     //               value: false,
//           //     //               groupValue: settings.useIOSStyle,
//           //     //               onChanged: (value) {
//           //     //                 analytics.setUserProperty(
//           //     //                     name: 'ux', value: 'android');
//           //     //                 settings.useIOSStyle = value;
//           //     //                 Navigator.of(context).pop();
//           //     //               },
//           //     //             ),
//           //     //           ],
//           //     //         ),
//           //     //       ),
//           //     //     ),
//           //     //   ],
//           //     // ),
//           //     // SettingsSection(
//           //     //   title: 'Cuenta',
//           //     //   tiles: [
//           //     //     SettingsTile(
//           //     //       title:
//           //     //           '${account.displayName == null ? 'Iniciar sesión' : 'Cambiar de cuenta'}',
//           //     //       subtitle:
//           //     //           '${account.displayName == null ? 'No hay ninguna sesión iniciada' : 'Iniciaste sesión como ${account.displayName}'}',
//           //     //       leading: Icon(Icons.switch_account),
//           //     //       onPressed: (context) {
//           //     //         analytics.logEvent(name: 'switch-user');
//           //     //         Navigator.of(context).push(
//           //     //           MaterialPageRoute(
//           //     //             builder: (context) => Scaffold(
//           //     //               body: SignInPage(onSignIn: () {
//           //     //                 Navigator.of(context).pop();
//           //     //               }),
//           //     //             ),
//           //     //           ),
//           //     //         );
//           //     //       },
//           //     //     ),
//           //     //     SettingsTile(
//           //     //       title: 'Cerrar sesión',
//           //     //       leading: Icon(Icons.logout),
//           //     //       onPressed: (context) {
//           //     //         analytics.logEvent(name: 'log-out');
//           //     //         account.logOut();
//           //     //       },
//           //     //     ),
//           //     //   ],
//           //     // ),
//           //     // SettingsSection(
//           //     //   title: 'Varios',
//           //     //   tiles: [
//           //     //     SettingsTile(
//           //     //       title: 'Notificaciones',
//           //     //       leading: Icon(Icons.notifications),
//           //     //       onPressed: (context) {
//           //     //         analytics.logEvent(name: 'open-notification-settings');
//           //     //         SystemSettings.appNotifications();
//           //     //       },
//           //     //     ),
//           //     //     SettingsTile(
//           //     //       title: 'Términos y condiciones',
//           //     //       leading: Icon(Icons.description),
//           //     //       onPressed: (context) {
//           //     //         analytics.logEvent(
//           //     //             name: 'view-terms',
//           //     //             parameters: {'source': 'settings'});
//           //     //         launch(
//           //     //           'https://proyecto-miyotl.web.app/terminos',
//           //     //           forceWebView: true,
//           //     //         );
//           //     //       },
//           //     //     ),
//           //     //     SettingsTile(
//           //     //         title: 'Política de privacidad',
//           //     //         leading: Icon(Icons.privacy_tip),
//           //     //         onPressed: (context) {
//           //     //           analytics.logEvent(
//           //     //               name: 'view-privacy',
//           //     //               parameters: {'source': 'settings'});
//           //     //           launch(
//           //     //             'https://proyecto-miyotl.web.app/privacidad',
//           //     //             forceWebView: true,
//           //     //           );
//           //     //         }),
//           //     //     SettingsTile(
//           //     //       title: 'Enviar retroalimentación',
//           //     //       leading: Icon(Icons.feedback),
//           //     //       onPressed: (context) {
//           //     //         analytics.logEvent(
//           //     //             name: 'contact', parameters: {'source': 'settings'});
//           //     //         launch(
//           //     //             'mailto:miyotl@googlegroups.com?subject=Retroalimentación sobre app');
//           //     //       },
//           //     //     ),
//           //     //     SettingsTile(
//           //     //       title: 'Opciones avanzadas y diagnósticos',
//           //     //       leading: Icon(Icons.bug_report),
//           //     //       onPressed: (context) {
//           //     //         analytics.logEvent(name: 'open-developer-menu');
//           //     //         Navigator.of(context).pushNamed('/debug');
//           //     //       },
//           //     //     ),
//           //     //   ],
//           //     // ),
//           //   ],
//           // ),
//         ),
//       ),
//     );
//   }
// }
