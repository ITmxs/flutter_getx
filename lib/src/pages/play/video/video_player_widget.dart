import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/play/video/video_details2_widget.dart';
// import 'package:flutter_ho/src/pages/play/video_details2_widget.dart';

import 'package:video_player/video_player.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

class VideoVideo extends StatefulWidget {

  
  VideoVideo({Key key}) : super(key: key);

  @override
  _VideoVideoState createState() => _VideoVideoState();
}

class _VideoVideoState extends State<VideoVideo> {
  //创建一个多订阅流
  StreamController<VideoPlayerController> _streamController =
      StreamController.broadcast();

  //当前播放视频的控制器
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    //添加一个消息监听
    _streamController.stream.listen((event) {
      print("接收到消息 ${event.textureId}");
      if (_videoPlayerController != null &&
          _videoPlayerController.textureId != event.textureId) {
        _videoPlayerController.pause();
      }
      _videoPlayerController = event;
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  bool _isScroll = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      backgroundColor: Colors.grey[200],
      body: NotificationListener(
        onNotification: (ScrollNotification notification) {
          Type runtimType = notification.runtimeType;

          print("runtimType $runtimType");
          if (runtimType == ScrollStartNotification) {
            print("开始滑动");
            _isScroll = true;
          } else if (runtimType == ScrollEndNotification) {
            print("结束滑动");
            _isScroll = false;
            setState(() {});
          }

          return false;
        },
        child: ListViewItemWidget(
          isScroll: _isScroll,
          streamController: _streamController,
        ),
      ),
    );
  }
}

class ListViewItemWidget extends StatefulWidget {
  final StreamController streamController;
  final isScroll;

  ListViewItemWidget({this.streamController, this.isScroll = false});

  @override
  _ListViewItemWidgetState createState() => _ListViewItemWidgetState();
}

class _ListViewItemWidgetState extends State<ListViewItemWidget> {
  bool offstage = true;
  @override
  Widget build(BuildContext context) {
    return offstage
        ? Container(
            margin: EdgeInsets.only(top: 2),
            padding: EdgeInsets.all(8),
            color: Colors.white,
            child: Column(
              children: [
                //第一部分，头像区域

                title(),
                //第二部分视频区域
                Container(
                    height: 220,
                    child: widget.isScroll
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "assets/images/welcome.png",
                              fit: BoxFit.fitWidth,
                            ),
                          )
                        : VideoDetailsWidget(
                            streamController: widget.streamController,
                          )),

                ///第三部分地点
                ElevatedButton.icon(
                  label: Row(
                    children: [
                      Text("地点"),
                      SizedBox(
                        width: 10,
                      ),
                      Text("距离")
                    ],
                  ),
                  icon: Icon(Icons.web),
                  style: ElevatedButton.styleFrom(
                    // background color
                    primary: Colors.grey,
                    // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),

                ///第四部分评论
                information(),
              ],
            ),
          )
        : Container();
  }

  Widget title() {
    return Container(
      // color: Colors.blue,
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
                "https://luckly007.oss-cn-beijing.aliyuncs.com/ff3a7c270d3b4169be336135fa924096.jpeg",
                height: 40,
                width: 40,
                fit: BoxFit.cover),
          ),
          Container(
            height: 100,
            padding: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Text("昵称"),
                Container(
                  child: Row(
                    children: [
                      Text("手机"),
                      Text("时间"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 200,
          ),
          Container(
            child: Image.network(
              "https://luckly007.oss-cn-beijing.aliyuncs.com/20210208104433.jpg",
              height: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget information() {
    return Container(
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _toggle();
              }),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              // background color
              primary: Colors.grey,
              // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              textStyle: TextStyle(fontSize: 20),
            ),
            label: Text('转发'),
            icon: Icon(Icons.web),
            onPressed: () {
              print('Pressed');
            },
          ),
          ElevatedButton.icon(
            label: Text('点赞'),
            icon: Icon(Icons.web),
            onPressed: () {
              print('Pressed');
            },
          ),
          ElevatedButton.icon(
            label: Text('pinlun'),
            icon: Icon(Icons.web),
            onPressed: () {
              print('Pressed');
            },
          )
        ],
      ),
    );
  }

  void _toggle() {
    setState(() {
      offstage = !offstage;
    });
  }
  // Widget buildVideoWidget() {
  //   if (widget.isScroll) {
  //     return Container(
  //       width: MediaQuery.of(context).size.width,
  //       child: Image.asset(
  //         "assets/images/welcome.png",
  //         fit: BoxFit.fitWidth,
  //       ),
  //     );
  //   }
  //   return VideoDetailsWidget(
  //     streamController: widget.streamController,
  //   );
  // }
}
