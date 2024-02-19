import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_state.dart';
import 'package:provider/provider.dart';
import 'google_doc.dart';

class CultureDetails extends StatelessWidget {
  final CultureEntry entry;

  const CultureDetails({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    AppState state = Provider.of<AppState>(context, listen: false);
    Source? source = state.sources.getSource(entry.sourceId);
    analytics.logViewItem(
      items: [
        AnalyticsEventItem(
          itemId: '${entry.titleOriginal}_${entry.titleTranslated}_details',
          itemName: 'Detalles de ${entry.titleTranslated}',
          itemCategory: 'document-details',
        ),
      ],
    );
    return Scaffold(
      /// TODO: mostrar imagen como sliver appbar
      appBar: AppBar(
        title: Text(
          entry.titleOriginal,
          style: const TextStyle(
                      fontFamily: 'FredokaOne'
                    )
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Texto en ${state.language}'),
            subtitle: Text('Toca para abrir ${entry.titleOriginal}'),
            trailing: const Icon(Icons.launch),
            onTap: () {
              Navigator.of(context).pop();
              openDoc(context, entry.linkOriginal, entry);
            },
          ),
          ListTile(
            title: const Text('Traducción al español'),
            subtitle: Text('Toca para abrir ${entry.titleTranslated}'),
            trailing: const Icon(Icons.launch),
            onTap: () {
              Navigator.of(context).pop();
              openDoc(context, entry.linkTranslated, entry);
            },
          ),
          ListTile(
            title: const Text('Categoría'),
            subtitle: Text(entry.category),
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
          ListTile(
            title: const Text('Etiquetas'),
            subtitle: Text(
              entry.tags.join(', '),
            ),
          ),
        ],
      ),
    );
  }
}
