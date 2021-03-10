import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoFullPage extends StatefulWidget {
  final VideoPlayerController controller;

  VideoFullPage(this.controller);

  @override
  _VideoFullState createState() => _VideoFullState();
}

class _VideoFullState extends State<VideoFullPage> {
  bool isLand = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              Center(
                child: Hero(
                  tag: "player",
                  child: AspectRatio(
                    aspectRatio: widget.controller.value.aspectRatio,
                    child: VideoPlayer(widget.controller),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, right: 20),
                child: IconButton(
                  icon: const BackButtonIcon(),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(isLand
              ? Icons.screen_lock_landscape
              : Icons.screen_lock_portrait),
          onPressed: () {
            setState(() {
              if (isLand) {
                isLand = !isLand;
                AutoOrientation.portraitUpMode();
              } else {
                isLand = !isLand;
                AutoOrientation.landscapeLeftMode();
              }
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (isLand == true) {
      AutoOrientation.portraitUpMode();
    }
  }
}
