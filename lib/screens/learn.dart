import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenguas/widgets/empty_state.dart';
import 'package:video_player/video_player.dart';

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('img/axolotl-gears.mp4')
      ..initialize().then((_) => setState(() {}))
      ..play()
      ..setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_controller.value.initialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          // Image.asset(
          //   'img/axolotl-gears.gif',
          //   width: MediaQuery.of(context).size.width * 0.80,
          // ),
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Text(
              'La función para aprender el idioma se agregará en una actualización futura',
              textAlign: TextAlign.center,
              style: GoogleFonts.fredokaOne(
                fontSize: 24,
              ),
            ),
          )
        ],
      ),
    );
  }
}
