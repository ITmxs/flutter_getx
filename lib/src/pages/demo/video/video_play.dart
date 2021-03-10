import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/demo/video/video_paly_full.dart';

import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://res.exexm.com/cw_145225549855002')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 200,
                  margin: EdgeInsets.only(
                      top: MediaQueryData.fromWindow(
                              WidgetsBinding.instance.window)
                          .padding
                          .top),
                  color: Colors.black,
                  child: _controller.value.initialized
                      ? Hero(
                          tag: "player",
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),
                ))
          ],
        ),
        persistentFooterButtons: <Widget>[
          Builder(
            builder: (context) {
              return FlatButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return VideoFullPage(_controller);
                  }));
                },
                color: Colors.blue,
                child: new Text(
                  "Full",
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
