import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenguas/screens/language_select.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<AppState>(
        builder: (context, state, child) => ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: FutureBuilder(
                future: UserAccount.displayName,
                builder: (context, snapshot) {
                  String content;
                  if (snapshot.hasError) {
                    content = 'Error';
                  } else if (snapshot.hasData) {
                    content = '${snapshot.data}';
                  } else {
                    content = 'Cargando nombre...';
                  }
                  return Text(content, style: GoogleFonts.fredokaOne());
                },
              ),
              accountEmail: FutureBuilder(
                future: UserAccount.email,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error');
                  } else if (snapshot.hasData) {
                    return Text('${snapshot.data}');
                  } else {
                    return Text('Cargando correo...');
                  }
                },
              ),
              currentAccountPicture: FutureBuilder(
                future: UserAccount.profilePicUrl,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(snapshot.data),
                    );
                  } else {
                    return CircleAvatar(
                        backgroundImage: AssetImage('img/icon-full-new.png'));
                  }
                },
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Cambiar idioma'),
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
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Ajustes'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Enviar retroalimentación'),
              onTap: () {
                launch(
                  'mailto:miyotl@googlegroups.com?subject=Retroalimentación sobre app',
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Acerca de'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
