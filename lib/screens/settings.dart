import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lenguas/models/app_state.dart';
import 'package:lenguas/models/settings.dart';
import 'package:lenguas/screens/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:system_settings/system_settings.dart';

class SettingsPage extends StatelessWidget {
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
        padding: EdgeInsets.all(8),
        child: Consumer2<Settings, UserAccount>(
          builder: (context, settings, account, child) => SettingsList(
            backgroundColor: Colors.transparent,
            sections: [
              SettingsSection(
                title: 'Apariencia',
                tiles: [
                  SettingsTile(
                    title: 'Tema',
                    subtitle: settings.theme.string(),
                    leading: Icon(Icons.lightbulb),
                    onPressed: (BuildContext context) {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: Text('Tema'),
                          children: [
                            for (var value in ThemeMode.values)
                              RadioListTile<ThemeMode>(
                                title: Text('${value.string()}'),
                                value: value,
                                groupValue: settings.theme,
                                onChanged: (value) {
                                  settings.theme = value;
                                  Navigator.of(context).pop();
                                },
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  SettingsTile(
                    title: 'Estilo',
                    subtitle: settings.useIOSStyle ? 'iOS' : 'Android',
                    leading: Icon(
                      settings.useIOSStyle
                          ? Ionicons.logo_apple
                          : Icons.android,
                    ),
                    onPressed: (context) => showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        title: Text('Estilo'),
                        children: [
                          RadioListTile<bool>(
                            title: Text('iOS'),
                            value: true,
                            groupValue: settings.useIOSStyle,
                            onChanged: (value) {
                              settings.useIOSStyle = value;
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile<bool>(
                            title: Text('Android'),
                            value: false,
                            groupValue: settings.useIOSStyle,
                            onChanged: (value) {
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
                title: 'Cuenta',
                tiles: [
                  SettingsTile(
                    title:
                        '${account.displayName == null ? 'Iniciar sesión' : 'Cambiar de cuenta'}',
                    subtitle:
                        '${account.displayName == null ? 'No hay ninguna sesión iniciada' : 'Iniciaste sesión como ${account.displayName}'}',
                    leading: Icon(Icons.switch_account),
                    onPressed: (context) {
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
                    title: 'Cerrar sesión',
                    leading: Icon(Icons.logout),
                    onPressed: (context) {
                      account.logOut();
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'Varios',
                tiles: [
                  SettingsTile(
                    title: 'Notificaciones',
                    leading: Icon(Icons.notifications),
                    onPressed: (context) {
                      SystemSettings.appNotifications();
                    },
                  ),
                  SettingsTile(
                    title: 'Forzar actualización de base de datos',
                    leading: Icon(Icons.update),
                    subtitle: 'Última actualización: bla bla bla',
                    onPressed: (context) {
                      Provider.of<AppState>(context).updateLanguageData();
                    },
                  ),
                  SettingsTile(
                    title: 'Términos y condiciones',
                    leading: Icon(Icons.description),
                    onPressed: (context) => launch(
                      'https://proyecto-miyotl.web.app/terminos',
                      forceWebView: true,
                    ),
                  ),
                  SettingsTile(
                    title: 'Política de privacidad',
                    leading: Icon(Icons.privacy_tip),
                    onPressed: (context) => launch(
                      'https://proyecto-miyotl.web.app/privacidad',
                      forceWebView: true,
                    ),
                  ),
                  SettingsTile(
                    title: 'Enviar retroalimentación',
                    leading: Icon(Icons.feedback),
                    onPressed: (context) => launch(
                        'mailto:miyotl@googlegroups.com?subject=Retroalimentación sobre app'),
                  ),
                  SettingsTile(
                    title: 'Opciones avanzadas y diagnósticos',
                    leading: Icon(Icons.bug_report),
                    onPressed: (context) =>
                        Navigator.of(context).pushNamed('/debug'),
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
