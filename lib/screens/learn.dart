import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenguas/widgets/empty_state.dart';

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  final List<String> wordsForLesson = [];

  @override
  Widget build(BuildContext context) {
    if (this.wordsForLesson.isEmpty) {
      return Center(
        child: EmptyState(
          'Todavía no hay textos para este idioma, estáte atento...',
          'img/axolotl-gears.gif',
        ),
      );
    } else {
      return Container(
          width: double.infinity,
          height: double.infinity,
          // TODO update colors based on constants
          color: Color.fromRGBO(54, 52, 127, 1),
          child: OrientationBuilder(builder: (context, orientation) {
            List<String> wordsLesson = this.wordsForLesson;
            return GridView.count(
                // Create a grid with 2 columns in portrait mode, or 3 columns in
                // landscape mode.
                crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
                // TODO update with the size of the lessons
                children: generateCards(wordsLesson));
          }));
    }
  }

  List<Widget> generateCards(List<String> words) {
    return List.generate(10, (index) {
      return Container(
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 400,
          decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 17,
                ),
                Text("Lección 1",
                    style: GoogleFonts.fredokaOne(
                        color: Colors.white, fontSize: 30)),
                SizedBox(
                  height: 5,
                ),
                Text("Danza",
                    style:
                        GoogleFonts.roboto(color: Colors.white, fontSize: 21)),
                Flexible(
                    child: Center(
                  child: Image(
                      image: AssetImage(
                    'img/banner.jpg',
                  )),
                )),
              ],
            ),
          ));
    });
  }
}
