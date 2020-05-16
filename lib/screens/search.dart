import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../widgets/empty_state.dart';
import 'dictionary.dart';

class DictionarySearchDelegate extends SearchDelegate {
  DictionarySearchDelegate()
      : super(
          searchFieldLabel: 'Busca una palabra',
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      tooltip: 'Regresarse',
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    AppState state = Provider.of<AppState>(context, listen: false);
    List<DictionaryEntry> searchResults = state.dictionary.search(query);

    return searchResults.length > 0
        ? ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) => buildListTile(
              context: context,
              entry: searchResults[index],
              mode: state.lookupMode,
            ),
          )
        : EmptyState('No se encontraron resultados para $query');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
