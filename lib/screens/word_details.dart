import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class WordDetails extends StatelessWidget {
  final DictionaryEntry entry;
  WordDetails({Key key, @required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Source source =
        Provider.of<AppState>(context).sources.getSource(entry.sourceId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de ${entry.originalWord}'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
                'Palabra en ${Provider.of<AppState>(context).language}'),
            subtitle: Text('${entry.originalWord}'),
          ),
          ListTile(
            title: Text('Palabra en español'),
            subtitle: Text('${entry.translatedWord}'),
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
        ],
      ),
    );
  }
}
