import 'dart:async';

import 'dart:ui';

import 'package:flutter/material.dart';

import '../video_details2_widget.dart';

class DemoPage extends StatefulWidget {
  final StreamController streamController;
  final isScroll;
  DemoPage({this.streamController, this.isScroll = false});
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  // 控制字段，控制是否删除
  bool offstage = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: offstage
            ? Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //第一部分，头像区域

                    title(),
                    //第二部分，视频显示区域
                    video(),

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
            : Container());
  }

  Widget title() {
    return Container(
      // color: Colors.blue,
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
                "https://luckly007.oss-cn-beijing.aliyuncs.com/ff3a7c270d3b4169be336135fa924096.jpeg",
                height: 100,
                width: 100,
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
            width: 100,
          ),
          Container(
            child: Image.network(
              "https://luckly007.oss-cn-beijing.aliyuncs.com/20210208104433.jpg",
              height: 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget video() {
    return Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Container(
          height: 220,
          child: widget.isScroll
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/welcome.png",
                    fit: BoxFit.fitWidth,
                  ),
                )
              : VideoDetails2Widget(
                  streamController: widget.streamController,
                )),
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
}
