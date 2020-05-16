import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'word_details.dart';

ListTile buildListTile(
    {DictionaryEntry entry, LookupMode mode, BuildContext context}) {
  String title, subtitle;
  if (mode == LookupMode.languageToSpanish) {
    title = '${entry.originalWord}';
    subtitle = '${entry.translatedWord}';
  } else {
    title = '${entry.translatedWord}';
    subtitle = '${entry.originalWord}';
  }
  return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WordDetails(entry: entry),
          ),
        );
      });
}

class DictionaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          child: Consumer<AppState>(
            builder: (context, state, child) =>
                CupertinoSlidingSegmentedControl<LookupMode>(
              children: {
                LookupMode.spanishToLanguage:
                    Text('Español-${state.languageName}'),
                LookupMode.languageToSpanish:
                    Text('${state.languageName}-Español'),
              },
              onValueChanged: (newMode) {
                state.changeLookupMode(newMode);
              },
              groupValue: state.lookupMode,
            ),
          ),
        ),
        Consumer<AppState>(
          builder: (context, state, child) => Expanded(
            child: state.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(
                      left: 14,
                      right: 14,
                      bottom: 14,
                    ),
                    itemCount: state.dictionary.entries.length,
                    itemBuilder: (context, index) {
                      return buildListTile(
                        entry: state.dictionary.entries[index],
                        mode: state.lookupMode,
                        context: context,
                      );
                    }),
          ),
        ),
      ],
    );
  }
}
