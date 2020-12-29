import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dictionary.dart';
import 'learn.dart';
import 'culture.dart';
import '../models/app_state.dart';
import '../widgets/drawer.dart';
import 'search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Consumer<AppState>(
          builder: (context, state, child) =>
              Text('$app_name: ${state.languageName}'),
        ),
        actions: <Widget>[
          if (page == 0) ...[
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
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueGrey,
                Colors.redAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: [DictionaryPage(), LearnPage(), CulturePage()][page],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            label: 'Diccionario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Aprende',
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
  }
}
