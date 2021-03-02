import 'package:flutter/material.dart';
import 'package:lenguas/models/app_state.dart';
import 'package:lenguas/widgets/status_bar_colors.dart';
import 'package:provider/provider.dart';

typedef LanguageSelectFunction = void Function(String);

class LanguageSelectPage extends StatelessWidget {
  /// Title of the page, if null it will be ommitted
  final String title;

  /// If not null, this will be run after changing the language
  final LanguageSelectFunction onLanguageSelect;

  LanguageSelectPage({this.title, this.onLanguageSelect});

  @override
  Widget build(BuildContext context) {
    return DarkStatusBar(
      child: Container(
        color: AppColors.morado,
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16),
              if (title != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                  ),
                ),
              Text(
                '¿Qué idioma quieres aprender?',
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
              ),
              Expanded(
                child: Consumer<AppState>(
                  builder: (context, state, child) {
                    return ListView(
                      padding: EdgeInsets.all(8),
                      shrinkWrap: true,
                      children: [
                        for (var language in state.languages)
                          Card(
                            child: ListTile(
                              title: Text('${language.name}'),
                              subtitle: Text('${language.speakers} hablantes'),
                              leading: Icon(Icons.language),
                              onTap: () {
                                /// Save onboarding finished and language
                                state.changeLanguage(language.name);
                                state.setOnboardingStatus(true);
                                state.setDefaultLanguage(state.language);
                                if (onLanguageSelect != null) {
                                  onLanguageSelect(language.name);
                                }
                              },
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
