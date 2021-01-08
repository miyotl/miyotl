import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lenguas/models/app_state.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../widgets/empty_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../models/constants.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  LiquidController controller;

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    controller = LiquidController();
    super.initState();
  }

  void nextPage() {
    controller.animateToPage(page: controller.currentPage + 1);
  }

  Future<UserCredential> signInWithGoogle() async {
    /// https://firebase.flutter.dev/docs/auth/social/#google

    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        enableSlideIcon: false,
        enableLoop: false,
        disableUserGesture: true,
        liquidController: controller,
        pages: [
          SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'img/miyotl.png',
                    width: MediaQuery.of(context).size.width * 0.66,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Miyotl',
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 64),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      'Nuestras lenguas prehispánicas son hoy raíz y vuelo luminoso de unión y paz.',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  RaisedButton(
                    child: Text(
                      'Empieza ahora',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.white),
                    ),
                    color: Colors.indigo,
                    onPressed: nextPage,
                  ),
                ],
              ),
              color: Colors.white,
            ),
          ),
          Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              appBarTheme: AppBarTheme(
                brightness: Brightness.dark,
                color: Colors.black,
              ),
              brightness: Brightness.dark,
              canvasColor: Colors.indigo[800],
              accentIconTheme: IconThemeData(color: Colors.white),
            ),
            child: Scaffold(
              body: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  child: FutureBuilder<FirebaseApp>(
                    future: _initialization,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return EmptyState('${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  'Inicia sesión o crea una cuenta',
                                  style: Theme.of(context).textTheme.headline4,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SignInButton(
                              Buttons.GoogleDark,
                              text: 'Iniciar sesión con Google',
                              onPressed: () async {
                                var credential = await signInWithGoogle();
                                AppState state = Provider.of<AppState>(
                                  context,
                                  listen: false,
                                );
                                state.firebaseCredential = credential;
                                nextPage();
                              },
                            ),
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: AppColors.guinda,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: 16),
                Consumer<AppState>(
                  builder: (context, state, child) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Hola, ${state.givenName}.',
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                Text(
                  'Quiero aprender:',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                ),
                ListView(
                  padding: EdgeInsets.all(8),
                  shrinkWrap: true,
                  children: [
                    Card(
                      child: ListTile(
                        title: Text('Bla'),
                        subtitle: Text('Ble'),
                        leading: Icon(Icons.access_alarms),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
