import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DemoSlidable(),
  ));
}

///代码清单
class DemoSlidable extends StatefulWidget {
  @override
  _DemoSlidableState createState() => _DemoSlidableState();
}

class _DemoSlidableState extends State<DemoSlidable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slidable"),
      ),
      backgroundColor: Color(0xfff2f2f2),
      body: buildListView(),
    );
  }

  //来一个列表
  ListView buildListView() {
    //列表
    return ListView.builder(
      //显示个数
      itemCount: 200,
      //每个子Item样式
      itemBuilder: (BuildContext context, int index) {
        //封装构建
        return buildItem(index);
      },
    );
  }

  Widget buildItem(int index) {
    //滑动组件
    return Slidable(
      key: ValueKey("$index"),
      //左滑删除
      //dismissal: buildSlidableDismissal(),
      //滑动方向
      direction: Axis.horizontal,
      //配置的是左侧
      actions: [],
      //配置的是右侧
      secondaryActions: secondaryActionsArray(),
      //滑动的交互效果
      // SlidableDrawerActionPane 从左逐渐压缩进来 折叠
      // SlidableScrollActionPane 相当于是从屏幕左侧滑动进来
      // SlidableBehindActionPane 直接显示在背面
      // SlidableStrechActionPane 从左侧压缩滑动进来
      actionPane: SlidableDrawerActionPane(),
      //列表显示的子Item
      child: buildContainer(),
    );
  }

  List<Widget> secondaryActionsArray() {
    return [
      // SlideAction(
      //   child: Container(
      //     color: Colors.blueGrey,
      //     child: Text("测试"),
      //   ),
      // ),
      // SlideAction(
      //   color: Colors.red,
      //   child: Text("测试2"),
      // ),
      IconSlideAction(
        icon: Icons.add,
        color: Colors.red,
        onTap: () {
          print("点击了add");
          //主动关闭
          Slidable.of(context).close();
        },
        closeOnTap: false,
      ),
      IconSlideAction(
        //图标
        icon: Icons.home,
        //背景色
        color: Colors.orange,
        //图标的颜色
        foregroundColor: Colors.white,
        //点击事件回调
        onTap: () {
          print("点击了add");
        },
        //点击 false 不关闭 ，true关闭
        closeOnTap: false,
      )
    ];
  }

  SlidableDismissal buildSlidableDismissal() {
    return SlidableDismissal(
      child: SlidableDrawerDismissal(),
      onWillDismiss: (actionType) {
        return showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('提示？'),
                content: Text('确定删除该条记录？'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('取消'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  FlatButton(
                    child: Text('确定'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              );
            });
      },
      onDismissed: (actionType) {
        print(actionType);
      },
    );
  }

  Container buildContainer() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          //左边的图片
          Image.asset(
            "assets/images/banner1.png",
            width: 100,
          ),
          //来点间距
          SizedBox(
            width: 16,
          ),
          //右侧的文字
          Expanded(
            //内容居左对齐
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "早起的年轻人",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "一个爱写代码 的程序员 也会早起那么一点点",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 10),
    );
  }

  Widget test() {
    ListView(
      children: <Widget>[
        Slidable(
          //滑动方式
          actionPane: SlidableScrollActionPane(),
          //滑出选项的面板 动画
          actionExtentRatio: 0.25,
          child: Container(),
          //左侧按钮列表
          actions: <Widget>[],
          //右侧按钮列表
          secondaryActions: <Widget>[],
          //删除动画
          dismissal: SlidableDismissal(
            child: SlidableDrawerDismissal(),
            onWillDismiss: (actionType) {
              //删除回调 一般是一个弹框
              return true;
            },
            onDismissed: (actionType) {
              print(actionType);
            },
          ),
        )
      ],
    );
  }
}
