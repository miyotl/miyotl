// @dart=2.9

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:miyotl/models/app_state.dart';
import 'package:miyotl/models/settings.dart';
import 'package:miyotl/screens/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:system_settings/system_settings.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajustes',
          style: GoogleFonts.fredokaOne(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer2<Settings, UserAccount>(
          builder: (context, settings, account, child) => SettingsList(
            darkTheme:
                SettingsThemeData(settingsListBackground: AppColors.darkBlue),
            sections: [
              SettingsSection(
                title: const Text('Apariencia'),
                tiles: [
                  SettingsTile(
                    title: const Text('Tema'),
                    value: Text(settings.theme.string()),
                    leading: Icon(settings.useIOSStyle
                        ? CupertinoIcons.lightbulb_fill
                        : Icons.lightbulb),
                    onPressed: (BuildContext context) {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('Tema'),
                          children: [
                            for (var value in ThemeMode.values)
                              RadioListTile<ThemeMode>(
                                title: Text(value.string()),
                                value: value,
                                groupValue: settings.theme,
                                onChanged: (value) {
                                  settings.theme = value;
                                  // analytics.setUserProperty(
                                  //     name: 'theme',
                                  //     value: '${settings.theme}');
                                  Navigator.of(context).pop();
                                },
                              ),
                          ],
                        ),
                      );
                    },
                  ),

                  /// Apple App store guidelines disallow mention of the word Android or the Android logo or its likeness
                  if (!Platform.isIOS)
                    SettingsTile(
                      title: const Text('Estilo'),
                      value: Text(settings.useIOSStyle ? 'iOS' : 'Android'),
                      leading: Icon(
                        settings.useIOSStyle
                            ? Ionicons.logo_apple
                            : Icons.android,
                      ),
                      onPressed: (context) => showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('Estilo'),
                          children: [
                            RadioListTile<bool>(
                              title: const Text('iOS'),
                              value: true,
                              groupValue: settings.useIOSStyle,
                              onChanged: (value) {
                                // analytics.setUserProperty(
                                //     name: 'ux', value: 'ios');
                                settings.useIOSStyle = value;
                                Navigator.of(context).pop();
                              },
                            ),
                            RadioListTile<bool>(
                              title: const Text('Android'),
                              value: false,
                              groupValue: settings.useIOSStyle,
                              onChanged: (value) {
                                // analytics.setUserProperty(
                                //     name: 'ux', value: 'android');
                                settings.useIOSStyle = value;
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              SettingsSection(
                title: const Text('Cuenta'),
                tiles: [
                  SettingsTile(
                    title: Text(
                      account.displayName == null
                          ? 'Iniciar sesión'
                          : (settings.useIOSStyle
                              ? 'Cuenta'
                              : 'Cambiar de cuenta'),
                    ),
                    value: Text(
                        account.displayName == null
                            ? 'No hay ninguna sesión iniciada'
                            : settings.useIOSStyle
                                ? account.displayName
                                : 'Iniciaste sesión como ${account.displayName}',
                        overflow: TextOverflow.fade),
                    leading: Icon(settings.useIOSStyle
                        ? CupertinoIcons.person_alt_circle
                        : Icons.switch_account),
                    onPressed: (context) {
                      // analytics.logEvent(name: 'switch-user');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            body: SignInPage(onSignIn: () {
                              Navigator.of(context).pop();
                            }),
                          ),
                        ),
                      );
                    },
                  ),
                  SettingsTile(
                    title: const Text('Cerrar sesión'),
                    leading: Icon(settings.useIOSStyle
                        ? CupertinoIcons.person_crop_circle_badge_xmark
                        : Icons.logout),
                    onPressed: (context) {
                      // analytics.logEvent(name: 'log-out');
                      account.logOut();
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: const Text('Varios'),
                tiles: [
                  SettingsTile.navigation(
                    title: const Text('Notificaciones'),
                    leading: Icon(settings.useIOSStyle
                        ? CupertinoIcons.bell_solid
                        : Icons.notifications),
                    onPressed: (context) {
                      // analytics.logEvent(name: 'open-notification-settings');
                      SystemSettings.appNotifications();
                    },
                  ),
                  SettingsTile(
                    title: const Text('Términos y condiciones'),
                    leading: Icon(settings.useIOSStyle
                        ? CupertinoIcons.square_favorites_alt_fill
                        : Icons.description),
                    onPressed: (context) {
                      // analytics.logEvent(
                      //     name: 'view-terms',
                      //     parameters: {'source': 'settings'});
                      launchUrl(
                        Uri.parse('https://proyecto-miyotl.web.app/terminos'),
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                  ),
                  SettingsTile(
                      title: const Text('Política de privacidad'),
                      leading: Icon(settings.useIOSStyle
                          ? CupertinoIcons.shield_lefthalf_fill
                          : Icons.privacy_tip),
                      onPressed: (context) {
                        // analytics.logEvent(
                        //     name: 'view-privacy',
                        //     parameters: {'source': 'settings'});
                        launchUrl(
                          Uri.parse(
                              'https://proyecto-miyotl.web.app/privacidad'),
                          mode: LaunchMode.inAppWebView,
                        );
                      }),
                  SettingsTile(
                    title: const Text('Enviar retroalimentación'),
                    leading: Icon(settings.useIOSStyle
                        ? CupertinoIcons.exclamationmark_bubble_fill
                        : Icons.feedback),
                    onPressed: (context) {
                      // analytics.logEvent(
                      //     name: 'contact', parameters: {'source': 'settings'});
                      launchUrl(
                        Uri.parse(
                            'mailto:miyotl@googlegroups.com?subject=Retroalimentación sobre app'),
                      );
                    },
                  ),
                  SettingsTile.navigation(
                    title: const Text('Opciones avanzadas y diagnósticos'),
                    leading: Icon(settings.useIOSStyle
                        ? CupertinoIcons.ant_fill
                        : Icons.bug_report),
                    onPressed: (context) {
                      // analytics.logEvent(name: 'open-developer-menu');
                      Navigator.of(context).pushNamed('/debug');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
