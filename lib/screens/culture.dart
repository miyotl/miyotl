import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenguas/screens/google_doc.dart';
import 'package:lenguas/widgets/empty_state.dart';
import 'package:provider/provider.dart';

import '../models/app_state.dart';
import 'culture_details.dart';

class CultureCard extends StatelessWidget {
  final CultureEntry entry;

  CultureCard({this.entry});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // TODO: mostrar el efecto de tinta de material design bien
      onTap: () {
        openDoc(context, entry.linkOriginal, entry);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(entry.titleOriginal),
              subtitle: Text('${entry.titleTranslated}'),
              leading: Consumer<AppState>(
                builder: (context, state, child) {
                  Source source = state.sources.getSource(entry.sourceId);
                  if (source.profilePicUrl != null) {
                    return CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(source.profilePicUrl),
                    );
                  } else {
                    return CircleAvatar(
                      child: Text(
                        '${source.author[0]}',
                        style: GoogleFonts.fredokaOne(),
                      ),
                    );
                  }
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CultureDetails(entry: entry),
                    ),
                  );
                },
              ),
            ),
            if (entry.imageUrl != null)
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: entry.imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
                      'img/banner.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            if (entry.imageUrl == null)
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Image.asset(
                    'img/banner.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ButtonBar(
              children: [
                Consumer<AppState>(
                  builder: (context, state, child) => TextButton(
                    child: Text('Leer en ${state.language}'),
                    onPressed: () {
                      openDoc(context, entry.linkOriginal, entry);
                    },
                  ),
                ),
                TextButton(
                  child: Text('Leer en español'),
                  onPressed: () {
                    openDoc(context, entry.linkTranslated, entry);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) {
        if (state.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.culture.length > 0) {
          return GridView.count(
            primary: true,
            crossAxisCount: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 0,
            ),
            children: <Widget>[
              for (CultureEntry entry in state.culture)
                CultureCard(entry: entry),
            ],
          );
        } else {
          return Center(
            child: EmptyState(
              'Todavía no hay textos para este idioma, estáte atento...',
              'img/axolotl-gears.gif',
            ),
          );
        }
      },
    );
  }
}
