import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miyotl/widgets/empty_state.dart';
import 'package:provider/provider.dart';
import 'dictionary.dart';
import 'learn.dart';
import 'culture.dart';
import '../models/app_state.dart';
import '../widgets/drawer.dart';
import 'search.dart';
import 'loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, widget) => FutureBuilder(
        future: state.loadPrefs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Error',
                    style: TextStyle(fontFamily: 'FredokaOne')),
              ),
              body: EmptyState(
                'Error: ${snapshot.error}',
                'img/axolotl-gears.gif',
              ),
            );
          } else if (snapshot.hasData) {
            return Scaffold(
              drawer: const AppDrawer(),
              appBar: AppBar(
                title: Consumer<AppState>(
                  builder: (context, state, child) {
                    return AutoSizeText(
                      '$app_name: ${state.languageName}',
                      style: const TextStyle(fontFamily: 'FredokaOne'),
                      maxLines: 1,
                    );
                  },
                ),
                actions: <Widget>[
                  if (page == 1) ...[
                    IconButton(
                      icon: Icon(PlatformIcons(context).search),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: DictionarySearchDelegate(),
                        );
                      },
                    ),
                  ],
                ],
              ),
              body: [LearnPage(), DictionaryPage(), CulturePage()][page],
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    label: 'Aprende',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.import_contacts),
                    label: 'Diccionario',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_balance),
                    label: 'Cultura',
                  ),
                ],
                onTap: (index) => setState(() {
                  page = index;
                }),
                currentIndex: page,
              ),
            );
          } else {
            return LoadingPage();
          }
        },
      ),
    );
  }
}
