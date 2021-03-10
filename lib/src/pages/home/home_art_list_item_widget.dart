import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/bean/bean_art.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/3.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class HomeItemArtWidget extends StatefulWidget {
  final ArtBean artBean;

  HomeItemArtWidget({this.artBean});

  @override
  _HomeItemArtWidgetState createState() => _HomeItemArtWidgetState();
}

// 控制字段
bool offstage = true;

class _HomeItemArtWidgetState extends State<HomeItemArtWidget> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height; //高度
    double w = MediaQuery.of(context).size.width; //宽度
//当前屏幕高度
    return _get();
  }

  void _toggle() {
    setState(() {
      offstage = !offstage;
    });
  }

  _get() {
    if (offstage) {
      return Container(
        //内边距
        padding: EdgeInsets.only(left: 12, top: 12, bottom: 12),
        //外边距
        margin: EdgeInsets.only(top: 4),
        //背景
        decoration: BoxDecoration(
          //线性渐变
          gradient: LinearGradient(
            colors: [
              Colors.orangeAccent.withOpacity(0.5),
              Colors.white,
            ],
            //开始角度左上角
            begin: Alignment.topLeft,
            //结束角度右下角
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          //包裹
          // mainAxisSize: MainAxisSize.min,
          //子Widget 左对齐
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //第一行的标题
            Container(
              width: 750,
              child: Text(
                "${111}",
                //  "${widget.artBean.artInfo}",

                style: TextStyle(
                  //设置文章的粗体
                  fontWeight: FontWeight.w600,
                  //文字的大小
                  fontSize: 18,
                ),
              ),
            ),

            ///中间的广告首页的图片
            buildImageWidget(),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Text("游戏001"),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: 3,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                  ),
                  Text("广告"),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "",
                      style: TextStyle(color: Colors.black),
                    ),
                    width: 100,
                  ),
                  IconButton(
                    // Icons.clear,
                    color: Colors.black.withOpacity(0.2),
                    onPressed: () {
                      _toggle();
                    },
                    icon: Icon(Icons.clear),
                  )
                ],
              ),
            ),
            // Center(
            //   child: _getToggleChild(),
            // )
          ],
        ),
      );
    } else {
      return new MaterialButton(
        onPressed: () {},
        child: new Container(),
      );
    }
  }

  ///中间的广告首页的图片
  Container buildImageWidget() {
    return Container(
      //外边距为 10
      margin: EdgeInsets.all(10),
      //圆角矩形裁剪
      child: ClipRRect(
        //四个角都裁剪的圆角
        borderRadius: BorderRadius.all(Radius.circular(6)),
        //加载一个本地资源图片
        child: Image.network(
          'https://img-blog.csdnimg.cn/20201128105150457.gif#pic_center',
          width: 500,
          height: 250,
          //图片 填充宽高
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
