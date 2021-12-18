import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/home_bloc.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/culture.dart';
import '../widgets/dictionary.dart';
import '../widgets/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Scaffold(
        appBar: MyAppBar(title: resolveTitle(state.selectedIndex)),
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

  String resolveTitle(int index) {
    switch (index) {
      case 0:
        return 'Diccionario';
      case 1:
        return 'Cultura';
      case 2:
        return 'Settings';
      default:
        return 'Miyotl';
    }
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
