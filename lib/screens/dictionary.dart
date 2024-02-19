import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'word_details.dart';

ListTile buildListTile(
    {required DictionaryEntry entry, required LookupMode mode, required BuildContext context}) {
  String title, subtitle;
  if (mode == LookupMode.languageToSpanish) {
    title = entry.originalWord;
    subtitle = entry.translatedWord;
  } else {
    title = entry.translatedWord;
    subtitle = entry.originalWord;
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
    },

    /// TODO(devillove): Implement this functionality
    // trailing: IconButton(
    //   icon: Icon(Icons.favorite_border),
    //   onPressed: () {
    //     Scaffold.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('Funcionalidad no implementada'),
    //       ),
    //     );
    //   },
    // ),
  );
}

class DictionaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
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
                analytics.logEvent(
                  name: 'change_dictionary_mode',
                  parameters: {'mode': '$newMode'},
                );
                analytics.setUserProperty(
                    name: 'dictionaryMode', value: '$newMode');
                state.changeLookupMode(newMode!);
              },
              groupValue: state.lookupMode,
            ),
          ),
        ),
        Consumer<AppState>(
          builder: (context, state, child) => Expanded(
            child: state.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : WordList(
                    itemCount: state.dictionary!.entries.length,
                    itemBuilder: (context, index) {
                      return buildListTile(
                        entry: state.dictionary!.entries[index],
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

class WordList extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const WordList({
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        left: 14,
        right: 14,
        bottom: 14,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
