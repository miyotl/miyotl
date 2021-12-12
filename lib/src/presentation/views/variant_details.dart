// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lenguas/src/core/utils/constants.dart';
// import 'package:provider/provider.dart';
//
// import 'models/app_state.dart';
//
// class VariantDetails extends StatelessWidget {
//   final DictionaryEntry entry;
//   final Variant variant;
//   VariantDetails({Key key, @required this.entry, @required this.variant})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     AppState state = Provider.of<AppState>(context);
//     Source source = state.sources.getSource(variant.sourceId);
//     analytics.logViewItem(
//         itemId: '${state.language}_${variant.word}_${entry.originalWord}',
//         itemName:
//             '${state.language}: ${variant.word} como variante para ${entry.translatedWord}',
//         itemCategory: 'variant');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Variante de ${entry.originalWord}',
//           style: GoogleFonts.fredokaOne(),
//         ),
//       ),
//       body: ListView(
//         children: <Widget>[
//           ListTile(
//             title: Text('Palabra original'),
//             subtitle: Text('${entry.originalWord}'),
//           ),
//           ListTile(
//             title: Text('Traducción al español'),
//             subtitle: Text('${entry.translatedWord}'),
//           ),
//           ListTile(
//             title: Text('Variante'),
//             subtitle: Text('${variant.word}'),
//           ),
//           ListTile(
//             title: Text('Autor'),
//             subtitle: Text(source?.author ?? 'Desconocido'),
//           ),
//           ListTile(
//             title: Text('Fuente'),
//             subtitle: Text(source?.name ?? 'Desconocida'),
//           ),
//           ListTile(
//             title: Text('Región'),
//             subtitle: Text(source?.region ?? 'Desconocida'),
//           ),
//         ],
//       ),
//     );
//   }
// }
