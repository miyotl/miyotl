import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'variant_details.dart';
import 'package:share_plus/share_plus.dart';

class WordDetails extends StatelessWidget {
  final DictionaryEntry entry;
  const WordDetails({required this.entry});

  @override
  Widget build(BuildContext context) {
    AppState state = Provider.of<AppState>(context);
    Source? source = state.sources.getSource(entry.sourceId);
    analytics.logViewItem(
      items: [
        AnalyticsEventItem(
            itemId:
                '${state.language}_${entry.translatedWord}_${entry.originalWord}',
            itemName:
                '${state.language}: ${entry.translatedWord} / ${entry.originalWord}',
            itemCategory: 'word')
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de ${entry.originalWord}',
          style: const TextStyle(
                      fontFamily: 'FredokaOne'
                    )
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(PlatformIcons(context).share),
            tooltip: 'Compartir',
            onPressed: () {
              Share.share('''*${entry.originalWord} (en ${state.language})*
${entry.translatedWord}
(Fuente: ${source?.author} de ${source?.region})

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
            subtitle: Text(entry.originalWord),
          ),
          ListTile(
            title: const Text('Palabra en español'),
            subtitle: Text(entry.translatedWord),
          ),
          if (entry.ipa != null)
            ListTile(
              title: const Text('Pronunciación'),
              subtitle: Text(entry.ipa),
            ),
          if (entry.originalExample != null)
            ListTile(
                title: const Text('Ejemplo'), subtitle: Text(entry.originalExample)),
          if (entry.translatedExample != null)
            ListTile(
              title: const Text('Traducción del ejemplo'),
              subtitle: Text(entry.translatedExample),
            ),
          for (Variant variant in entry.variants)
            ListTile(
              title: Text('Variante: ${variant.word}'),
              subtitle:
                  Text('${state.sources.getSource(variant.sourceId)?.region}'),
              trailing: const Icon(Icons.keyboard_arrow_right),
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
