import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenguas/src/core/utils/constants.dart';
import 'package:lenguas/src/presentation/views/search.dart';
import 'package:lenguas/src/presentation/widgets/drawer.dart';
import 'package:lenguas/src/presentation/widgets/empty_state.dart';
import 'package:provider/provider.dart';
import 'dictionary.dart';
import 'learn.dart';
import 'loading.dart';
import 'models/app_state.dart';

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
                title: Text(
                  'Error',
                  style: GoogleFonts.fredokaOne(),
                ),
              ),
              body: EmptyState('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return Scaffold(
              drawer: AppDrawer(),
              appBar: AppBar(
                title: Consumer<AppState>(
                  builder: (context, state, child) {
                    return AutoSizeText(
                      '$app_name: ${state.languageName}',
                      style: GoogleFonts.fredokaOne(),
                      maxLines: 1,
                    );
                  },
                ),
                actions: <Widget>[
                  if (page == 1) ...[
                    IconButton(
                      icon: Icon(Icons.search),
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
              // [LearnPage(), DictionaryPage(), CulturePage()][page]
              body: LearnPage(),
              bottomNavigationBar: BottomNavigationBar(
                items: [
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
