import 'package:flutter/material.dart';
import 'package:lenguas/src/core/utils/constants.dart';
import 'package:lenguas/src/presentation/widgets/empty_state.dart';
import 'package:provider/provider.dart';

import 'dictionary.dart';
import 'models/app_state.dart';

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
    analytics.logSearch(searchTerm: query);

    return searchResults.isNotEmpty
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
