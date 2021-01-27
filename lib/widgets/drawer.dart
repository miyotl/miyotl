import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

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
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Text(
                    app_name,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${state.languageName}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Colors.white),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
            ),
            if (state.dictionaries == null)
              Text('Espera, sigue cargando')
            else
              for (var language in state.dictionaries.keys)
                ListTile(
                  title: Text(
                    capitalize(language),
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: language == state.language
                              ? Theme.of(context).accentColor
                              : Theme.of(context).textTheme.bodyText1.color,
                        ),
                  ),
                  selected: language == state.language,
                  onTap: () => state.changeLanguage(language),
                ),
          ],
        ),
      ),
    );
  }
}
