import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dictionary.dart';
import 'learn.dart';
import 'culture.dart';
import 'developer_menu.dart';
import '../models/app_state.dart';
import '../widgets/drawer.dart';
import 'search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Consumer<AppState>(
          builder: (context, state, child) {
            /// For small screens, only display the  language name
            /// https://stackoverflow.com/questions/51114778/how-to-check-if-flutter-text-widget-was-overflowed
            return LayoutBuilder(builder: (context, size) {
              final tp = TextPainter(
                text: TextSpan(
                  text: '$app_name: ${state.languageName}',
                ),
                textDirection: TextDirection.ltr,
              );
              tp.layout(maxWidth: size.maxWidth);

              /// This weird substraction is pretty arbitrary,
              /// but I couldn't find a better solution for the moment
              if (tp.maxIntrinsicWidth <= size.maxWidth - 22) {
                return Text('$app_name: ${state.languageName}');
              } else {
                return Text('${state.languageName}');
              }
            });
          },
        ),
        actions: <Widget>[
          if (page == 1) ...[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Provider.of<AppState>(context, listen: false).getData();
              },
              tooltip: 'Actualizar',
            ),
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
          IconButton(
            icon: Icon(Icons.bug_report),
            tooltip: 'Menú del desarrollador',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DeveloperPage(),
              ));
            },
          ),
        ],
      ),
      body: [LearnPage(), DictionaryPage(), CulturePage()][page],
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.public_sharp),
        onPressed: () {},
      ),
    );
  }
}
