import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      child: Theme(
        data: new_light_theme,
        child: Container(
          color: AppColors.azulMorado,
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
                      style: GoogleFonts.fredokaOne(
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
                              // color: Colors.white,
                              child: ListTile(
                                title: Text('${language.name}'),
                                subtitle:
                                    Text('${language.speakers} hablantes'),
                                leading: CircleAvatar(
                                  child: Text(
                                    '${language.name[0]}',
                                    style: GoogleFonts.fredokaOne(),
                                  ),
                                ),
                                onTap: () {
                                  /// Save onboarding finished and language
                                  analytics.setUserProperty(
                                      name: 'language', value: language.name);
                                  state.changeLanguage(language.name);
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
      ),
    );
  }
}
