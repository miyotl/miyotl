import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class VariantDetails extends StatelessWidget {
  final DictionaryEntry entry;
  final Variant variant;
  const VariantDetails({super.key, required this.entry, required this.variant});

  @override
  Widget build(BuildContext context) {
    AppState state = Provider.of<AppState>(context);
    Source? source = state.sources.getSource(variant.sourceId);
    analytics.logViewItem(
      items: [
        AnalyticsEventItem(
            itemId: '${state.language}_${variant.word}_${entry.originalWord}',
            itemName:
                '${state.language}: ${variant.word} como variante para ${entry.translatedWord}',
            itemCategory: 'variant'),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Variante de ${entry.originalWord}',
          style: const TextStyle(
                      fontFamily: 'FredokaOne'
                    )
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Palabra original'),
            subtitle: Text('${entry.originalWord}'),
          ),
          ListTile(
            title: const Text('Traducción al español'),
            subtitle: Text('${entry.translatedWord}'),
          ),
          ListTile(
            title: const Text('Variante'),
            subtitle: Text('${variant.word}'),
          ),
          ListTile(
            title: const Text('Autor'),
            subtitle: Text(source?.author ?? 'Desconocido'),
          ),
          ListTile(
            title: const Text('Fuente'),
            subtitle: Text(source?.name ?? 'Desconocida'),
          ),
          ListTile(
            title: const Text('Región'),
            subtitle: Text(source?.region ?? 'Desconocida'),
          ),
        ],
      ),
    );
  }
}
