import 'dart:async';

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
  bool _isPlay = false;
  Timer _timer;
  double _opacity = 1.0;
  bool _isFirst = true;
  @override
  void initState() {
    super.initState();

    //视频播放的实时更新
    widget.controller.addListener(() {
      if (_isPlay && !widget.controller.value.isPlaying) {
        _isPlay = false;
        setState(() {});
      }

      //视频播放的当前时间进度
      Duration currentDuration = widget.controller.value.position;
      //视频的总时长
      Duration totalDuration = widget.controller.value.duration;

      //滑动条进度
      _currentSlider =
          currentDuration.inMilliseconds / totalDuration.inMilliseconds;
      if (_opacity == 1.0) {
        _streamController.add(0);
      }
    });
  }

  ///控制层点击事件
  void controllerClickFunction() {
    //获取当前视频是否在播放
    bool isPlaying = widget.controller.value.isPlaying;
    if (isPlaying) {
      //如果视频正在播放中 再次点击停止播放
      stopVideo();
      //停止播放状态下 取消隐藏的计时器
      if (_timer.isActive) {
        _timer.cancel();
      }
    } else {
      //开始播放视频
      startPlayVide();
      //创建一个延时执行的定时器
      _timer = Timer(Duration(seconds: 3), () {
        //3秒后将控制层的透明度设置为0
        //控制层还在
        setState(() {
          _opacity = 0.0;
        });
      });
    }
  }

  ///开始播放视频
  void startPlayVide() {
    //发送消息
    //先暂停再播放
    // if (widget.streamController != null) {
    //   widget.streamController.add(widget.controller);
    // }

    //当前视频 播放的位置
    Duration postion = widget.controller.value.position;
    //视频的总长度
    Duration duration = widget.controller.value.duration;

    if (postion == duration) {
      //播放完毕 再点击播放时，当播放位置滑动到开始位置
      widget.controller.seekTo(Duration.zero);
    }
    //开始播放
    widget.controller.play();

    setState(() {});
  }

  double _currentSlider = 0.0;
  StreamController<int> _streamController = new StreamController();

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
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                height: 60,
                child: buildBottomController(),
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

  buildBottomController() {
    if (_isFirst) {
      return Container();
    }
    //评论区有文章回复支持
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Row(
          children: [
            Text(
              buildStartText(),
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            Expanded(
              child: Slider(
                //滑动条当前的进度
                value: _currentSlider,
                //滑动条滑动时的回调
                onChanged: (value) {
                  setState(() {
                    _currentSlider = value;
                    //控制视频
                    widget.controller
                        .seekTo(widget.controller.value.duration * value);
                  });
                },
                min: 0.0,
                max: 1.0,
                //滑动条的底色
                inactiveColor: Colors.white,
                //滑动条的进度颜色
                activeColor: Colors.redAccent,
              ),
            ),
            Text(
              buildEndText(),
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            //全屏播放按钮
          ],
        );
      },
    );
  }

  //获取时实播放的时间
  String buildStartText() {
    //视频当前的播放进度
    Duration duration = widget.controller.value.position;
    int m = duration.inMinutes;
    int s = duration.inSeconds;

    String mStr = "$m";
    if (m < 10) {
      mStr = "0$m";
    }
    String sStr = "$s";
    if (s < 10) {
      sStr = "0$s";
    }

    return "$mStr:$sStr";
  }

  String buildEndText() {
    //视频总的时长
    Duration duration = widget.controller.value.duration;
    int m = duration.inMinutes;
    int s = duration.inSeconds;

    String mStr = "$m";
    if (m < 10) {
      mStr = "0$m";
    }
    String sStr = "$s";
    if (s < 10) {
      sStr = "0$s";
    }

    return "$mStr:$sStr";
  }

  ///停止播放视频
  void stopVideo() {
    //视频播放控制器停止播放
    widget.controller.pause();
    //变量标识
    _isPlay = false;
  }
}
