import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_view/pagination_view.dart';

import '../../config/themes/app_theme.dart';
import '../../core/types/vital_status.dart';
import '../../domain/entities/character.dart';
import '../blocs/home/home_bloc.dart';
import 'status_empty.dart';
import 'status_error.dart';

class Dictionary extends StatelessWidget {
  const Dictionary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => Column(
            children: [languageControl(state, context), wordList(context)]));
  }

  Widget languageControl(HomeState state, BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        child: CupertinoSlidingSegmentedControl<LookupMode>(
          backgroundColor: AppTheme.rosa,
          children: {
            LookupMode.originalLanguage: Text('originalLanguage'),
            LookupMode.targetLanguage: Text('targetLanguage'),
          },
          onValueChanged: (newMode) {
            context.read<HomeBloc>().updateDisplayMode(newMode!);
          },
          groupValue: context.read<HomeBloc>().displayMode(),
        ));
  }

  Widget wordList(BuildContext context) {
    return Expanded(
        child: PaginationView<Character>(
      itemBuilder: (context, character, index) => ListTile(
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(character.image),
        ),
        title: Text(character.name),
        subtitle: Text(character.species),
        trailing: character.vitalStatus.when(
          alive: () => Icon(Icons.tag_faces),
          dead: () => Icon(Icons.sentiment_very_dissatisfied),
          unknown: () => Icon(Icons.help_outline),
        ),
      ),
      pageFetch: context.read<HomeBloc>().getCharactersInPage,
      onEmpty: StatusEmpty(),
      onError: (exception) => StatusError(exception: exception),
    ));
  }
}
