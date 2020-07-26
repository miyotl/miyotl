import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'culture_details.dart';

class CultureCard extends StatelessWidget {
  final CultureEntry entry;

  CultureCard({this.entry});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      /// TODO: mostrar el efecto de tinta de material design bien
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CultureDetails(entry: entry),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(entry.titleOriginal),
              subtitle: Text(entry.titleTranslated),
            ),

            /// TODO: hacer cache a la imagen (CachedNetworkImage)
            /// TODO: arreglar overflow
            if (entry.imageUrl != null)
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Container(
                  child: Image.network(
                    entry.imageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
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
        } else {
          return GridView.count(
            primary: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: EdgeInsets.all(10),
            children: <Widget>[
              for (CultureEntry entry in state.culture)
                CultureCard(entry: entry),
            ],
          );
        }
      },
    );
  }
}
