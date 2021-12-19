import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../blocs/home_bloc.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAppVersion();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => ListView(
        padding: const EdgeInsets.all(8),
        children: [profileInfo(context), aboutUs(context), privacy(context)],
      ),
    );
  }

  Widget profileInfo(BuildContext context) => Container(
          child: Column(children: [
        SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Profile',
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.blue)),
            )),
        CircleAvatar(
          radius: 50,
          backgroundImage: CachedNetworkImageProvider(
              'https://duolingo-images.s3.amazonaws.com/avatars/208083270/PoHRc-ofY8/xxlarge'),
        ),
        Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: TextField(
                controller:
                    TextEditingController(text: 'Jose Luis Crisostomo Sanchez'),
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  border: null,
                  labelText: 'Usuario',
                ))),
        Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: TextField(
                controller: TextEditingController(text: 'jl.cs606@gmail.com'),
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  border: null,
                  labelText: 'Email',
                ))),
        Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: languageSpinner(context)),
        Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: OutlinedButton(
              onPressed: () {
                /* TODO add action to logout*/
              },
              child: Text('Log out'),
            )),
      ]));

  Widget languageSpinner(BuildContext context) {
    var languageLearning = 'One';
    var spinnerItems = <String>['One', 'Two', 'Three', 'Four', 'Five'];
    // TODO agregar los lenguajes
    return DropdownButton<String>(
      isExpanded: true,
      value: languageLearning,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style:
          Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.grey.shade300,
      ),
      onChanged: (data) {
        if (data != null) {
          languageLearning = data;
        }
      },
      items: spinnerItems.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget aboutUs(BuildContext context) {
    final contactUrl =
        'mailto:miyotl@googlegroups.com?subject=Retroalimentación sobre app';
    final aboutUs = 'https://proyecto-miyotl.web.app/';

    return Column(children: [
      Padding(
          padding: EdgeInsets.only(top: 40, left: 16, bottom: 16),
          child: SizedBox(
            width: double.infinity,
            child: Text('Sobre nosotros',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.blue)),
          )),
      Padding(
          padding: EdgeInsets.only(left: 16, bottom: 4),
          child: SizedBox(
            width: double.infinity,
            child: InkWell(
                onTap: () => launch(contactUrl),
                child: createHyperlinkText(
                    '', 'Contacto', contactUrl, TextAlign.start)),
          )),
      Padding(
          padding: EdgeInsets.only(left: 16),
          child: SizedBox(
            width: double.infinity,
            child: InkWell(
                onTap: () => launch(aboutUs),
                child: createHyperlinkText(
                    '', 'Equipo Miyotl', aboutUs, TextAlign.start)),
          ))
    ]);
  }

  Widget privacy(BuildContext context) {
    final termsUrl = 'https://proyecto-miyotl.web.app/terminos';
    final privacyPolicy = 'https://proyecto-miyotl.web.app/privacidad';

    return Column(children: [
      SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Legal',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.blue)),
          )),
      Padding(
          padding: EdgeInsets.only(left: 16, bottom: 4),
          child: SizedBox(
            width: double.infinity,
            child: InkWell(
                onTap: () => launch(termsUrl),
                child: createHyperlinkText('', 'Política de privacidad',
                    privacyPolicy, TextAlign.start)),
          )),
      Padding(
          padding: EdgeInsets.only(left: 16, top: 4, bottom: 40),
          child: SizedBox(
            width: double.infinity,
            child: InkWell(
                onTap: () => launch(termsUrl),
                child: createHyperlinkText(
                    '', 'Términos y Condiciones', termsUrl, TextAlign.start)),
          ))
    ]);
  }

  Widget createHyperlinkText(String text, String textForLink, String urlTarget,
          TextAlign customAlignment) =>
      RichText(
        textAlign: customAlignment,
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: textForLink,
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launch(urlTarget);
                },
            ),
          ],
        ),
      );

  Future<String> getAppVersion() async =>
      PackageInfo.fromPlatform().then((packageInfo) {
        var version = packageInfo.version;
        var buildNumber = packageInfo.buildNumber;
        return "version: $version build : $buildNumber";
      });
}
