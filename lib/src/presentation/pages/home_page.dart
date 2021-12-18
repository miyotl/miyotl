import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenguas/src/presentation/widgets/dictionary.dart';
import 'package:lenguas/src/presentation/widgets/culture.dart';
import 'package:lenguas/src/presentation/widgets/settings.dart';

import '../blocs/home_bloc.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  String _page_title = "Diccionario";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Scaffold(
        appBar: MyAppBar(_page_title),
        body: _getScreenFromIndex(state.selectedIndex),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: state.selectedIndex,
          onItemSelected: (index) =>
              context.read<HomeBloc>().add(HomeEvent.itemSelected(index)),
          items: [
            BottomNavBarItem(
              textAlign: TextAlign.center,
              icon: Icon(AntIcons.book_outline),
              title: Text('Diccionario'),
            ),
            BottomNavBarItem(
              textAlign: TextAlign.center,
              icon: Icon(AntIcons.read_outline),
              title: Text('Cultura'),
            ),
            BottomNavBarItem(
              textAlign: TextAlign.center,
              icon: Icon(AntIcons.setting_outline),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getScreenFromIndex(int selectedIndex) {
    // https://www.figma.com/file/lLBQEbOVpHIHMFrGmxULng/Miyotl-Versi%C3%B3n-2.0?node-id=7%3A13068
    switch (selectedIndex) {
      case 0:
        return Dictionary();
      case 1:
        return Culture();
      default:
        return Settings();
    }
  }
}
