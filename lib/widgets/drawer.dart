import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miyotl/screens/language_select.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ionicons/ionicons.dart';
import 'package:miyotl/models/constants.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sentry/sentry.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<AppState>(
        builder: (context, state, child) {
          analytics.logEvent(name: 'open_drawer');
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Consumer<UserAccount>(
                builder: (context, account, child) {
                  return UserAccountsDrawerHeader(
                    accountName: Text(
                      account.displayName ?? '',
                      style: const TextStyle(fontFamily: 'FredokaOne'),
                    ),
                    accountEmail: Text(account.email ?? ''),
                    currentAccountPicture: CircleAvatar(
                      foregroundImage: account.profilePic,
                      // TODO: edit Theme directly for this and don't hardcode
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? null
                              : AppColors.rosa, // pick better color?
                      child: AutoSizeText(
                        account.getInitials(),

                        /// TODO: make it nicer-looking, probably like the Apple one
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'FredokaOne'),
                        wrapWords: false,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.secondary,
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                    Platform.isIOS ? CupertinoIcons.globe : Icons.language),
                title: const Text('Cambiar idioma'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: LanguageSelectPage(
                        title: 'Selecciona el idioma',
                        onLanguageSelect: (language) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ));
                },
              ),
              Consumer<AppState>(
                builder: (context, state, widget) => ListTile(
                  leading: Icon(
                      Platform.isIOS ? CupertinoIcons.refresh : Icons.update),
                  title: const Text('Actualizar base de datos'),
                  subtitle: FutureBuilder(
                    future: state.lastUpdate,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text('Últ. act: ${snapshot.data}');
                      } else {
                        return const Text('');
                      }
                    },
                  ),
                  onTap: () async {
                    analytics.logEvent(name: 'manual_refresh');
                    try {
                      await state.updateLanguageData();
                    } on SocketException {
                      showPlatformDialog(
                        context: context,
                        builder: (context) {
                          return PlatformAlertDialog(
                            title: const Text('No tienes internet'),
                            content: const Text(
                                'No se pudo intentar actualizar la base de datos porque no tienes conexión a internet.'),
                            actions: [
                              PlatformDialogAction(
                                child: PlatformText('De acuerdo'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e, stackTrace) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PlatformAlertDialog(
                            title: const Text('Error desconocido'),
                            content: Text(e.toString()),
                            actions: [
                              PlatformDialogAction(
                                child: const Text('Reportar error'),
                                onPressed: () {
                                  launchUrl(Uri.parse(
                                      'mailto:miyotl@googlegroups.com?subject=Error al actualizar base de datos&body=$e'));
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      Sentry.captureException(e, stackTrace: stackTrace);
                    }
                  },
                ),
              ),
              ListTile(
                leading: Icon(PlatformIcons(context).settings),
                title: const Text('Ajustes'),
                onTap: () {
                  analytics.logEvent(name: 'open_settings');
                  Navigator.of(context).pushNamed('/settings');
                },
              ),
              ListTile(
                leading: Icon(PlatformIcons(context).share),
                title: const Text('Compartir aplicación'),
                onTap: () {
                  analytics.logShare(
                      contentType: 'invite', itemId: 'app', method: 'drawer');
                  Share.share(
                      '¿Sabías que hay una app donde puedes acercarte a nuestras lenguas indígenas? ¡Próximamente podrás aprenderlas!\n\nDescárgala en miyotl.org');
                },
              ),
              ListTile(
                leading: Icon(Platform.isIOS
                    ? CupertinoIcons.exclamationmark_bubble
                    : Icons.feedback),
                title: const Text('Enviar retroalimentación'),
                onTap: () {
                  analytics.logEvent(
                      name: 'contact', parameters: {'source': 'drawer'});
                  launchUrl(
                    Uri.parse(
                        'mailto:miyotl@googlegroups.com?subject=Retroalimentación sobre app'),
                  );
                },
              ),
              ListTile(
                leading: Icon(PlatformIcons(context).info),
                title: const Text('Acerca de'),
                onTap: () {
                  analytics.logEvent(name: 'open_about');
                  showAboutDialog(
                    context: context,
                    applicationIcon: const CircleAvatar(
                      backgroundImage: AssetImage('img/icon-full-new.png'),
                      backgroundColor: Colors.white,
                    ),
                    applicationLegalese: 'Con amor desde Chapingo ❤️',
//                       '''Fundadores y mesa directiva: Emilio Álvarez (CEO), Gabriel Rodríguez (CTO), Daniela Madrigal (COO), Carter Dieguiño (CFO y abogado),
// Código: Gabriel Rodríguez
// Dibujos y CMO: Camila Varela
// Con amor desde Chapingo ❤️''',
                    applicationVersion: 'versión inicial',
                    children: [
                      ListTile(
                        leading: const Icon(Icons.people),
                        title: const Text('Ver créditos'),
                        onTap: () {
                          analytics.logEvent(name: 'view_credits');
                          launchUrl(
                            Uri.parse(
                                'https://proyecto-miyotl.web.app/acerca_de'),
                            mode: LaunchMode.inAppWebView,
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Ionicons.logo_facebook),
                        title: const Text('Síguenos en Facebook'),
                        onTap: () {
                          analytics.logEvent(name: 'view_facebook');
                          launchUrl(Uri.parse('https://fb.me/MiyotlApp'));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Ionicons.logo_twitter),
                        title: const Text('Síguenos en Twitter'),
                        onTap: () {
                          analytics.logEvent(name: 'view_twitter');
                          launchUrl(Uri.parse('https://twitter.com/MiyotlApp'));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Mándanos un correo'),
                        onTap: () {
                          analytics.logEvent(
                              name: 'contact', parameters: {'source': 'about'});
                          launchUrl(
                              Uri.parse('mailto:miyotl@googlegroups.com'));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Ionicons.logo_github),
                        title: const Text('Colabora en GitHub'),
                        onTap: () {
                          analytics.logEvent(name: 'view_github');
                          launchUrl(
                              Uri.parse('https://github.com/miyotl/miyotl'));
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
