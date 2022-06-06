// @dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'variant_details.dart';
import 'package:share_plus/share_plus.dart';

class WordDetails extends StatelessWidget {
  final DictionaryEntry entry;
  WordDetails({Key key, @required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState state = Provider.of<AppState>(context);
    Source source = state.sources.getSource(entry.sourceId);
    // analytics.logViewItem(
    //     itemId:
    //         '${state.language}_${entry.translatedWord}_${entry.originalWord}',
    //     itemName:
    //         '${state.language}: ${entry.translatedWord} / ${entry.originalWord}',
    //     itemCategory: 'word');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de ${entry.originalWord}',
          style: GoogleFonts.fredokaOne(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            tooltip: 'Compartir',
            onPressed: () {
              Share.share('''*${entry.originalWord} (en ${state.language})*
${entry.translatedWord}
(Fuente: ${source.author} de ${source.region})

Compartido desde Miyotl. Descárgalo en miyotl.org''');
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title:
                Text('Palabra en ${Provider.of<AppState>(context).language}'),
            subtitle: Text('${entry.originalWord}'),
          ),
          ListTile(
            title: Text('Palabra en español'),
            subtitle: Text('${entry.translatedWord}'),
          ),
          if (entry.ipa != null)
            ListTile(
              title: Text('Pronunciación'),
              subtitle: Text(entry.ipa),
            ),
          if (entry.originalExample != null)
            ListTile(
                title: Text('Ejemplo'), subtitle: Text(entry.originalExample)),
          if (entry.translatedExample != null)
            ListTile(
              title: Text('Traducción del ejemplo'),
              subtitle: Text(entry.translatedExample),
            ),
          for (Variant variant in entry.variants)
            ListTile(
              title: Text('Variante: ${variant.word}'),
              subtitle:
                  Text('${state.sources.getSource(variant.sourceId).region}'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VariantDetails(
                      entry: entry,
                      variant: variant,
                    ),
                  ),
                );
              },
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
