import 'package:flutter/material.dart';
import '../models/app_state.dart';
import 'package:provider/provider.dart';
import 'google_doc.dart';

class CultureDetails extends StatelessWidget {
  final CultureEntry entry;

  CultureDetails({this.entry});

  @override
  Widget build(BuildContext context) {
    AppState state = Provider.of<AppState>(context, listen: false);
    Source source = state.sources.getSource(entry.sourceId);
    return Scaffold(
      /// TODO: mostrar imagen como sliver appbar
      appBar: AppBar(
        title: Text(entry.titleOriginal),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Texto en ${state.language}'),
            subtitle: Text('Toca para abrir ${entry.titleOriginal}'),
            trailing: Icon(Icons.launch),
            onTap: () {
              openDoc(context, entry.linkOriginal, entry);
            },
          ),
          ListTile(
            title: Text('Traducción al español'),
            subtitle: Text('Toca para abrir ${entry.titleTranslated}'),
            trailing: Icon(Icons.launch),
            onTap: () {
              openDoc(context, entry.linkTranslated, entry);
            },
          ),
          ListTile(
            title: Text('Categoría'),
            subtitle: Text(entry?.category ?? 'Ninguna'),
          ),
          ListTile(
            title: Text('Autor'),
            subtitle: Text(source?.author ?? 'Desconocido'),
          ),
          ListTile(
            title: Text('Fuente'),
            subtitle: Text(source?.name ?? 'Desconocida'),
          ),
          ListTile(
            title: Text('Región'),
            subtitle: Text(source?.region ?? 'Desconocida'),
          ),
          ListTile(
            title: Text('Etiquetas'),
            subtitle: Text(
              '${entry.tags?.join(', ') ?? 'Ninguna'}',
            ),
          ),
        ],
      ),
    );
  }
}
