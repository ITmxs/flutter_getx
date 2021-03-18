
class DragWidget extends StatefulWidget {
  final Widget child;

  const DragWidget({Key key, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DragWidgetState();
  }
}

class _DragWidgetState extends State<DragWidget>
    with SingleTickerProviderStateMixin {
  //动画控制器
  AnimationController _animationController;

  //动画
  Animation<Alignment> _animation;

  //定义按下的
  Alignment _dragAlignment = Alignment(0, 0);

  @override
  void initState() {
    super.initState();
    //创建动画控制器
    _animationController = AnimationController.unbounded(vsync: this);
    //动画控制器的监听
    _animationController.addListener(() {});
  }

  @override
  void dispose() {
    //销毁
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      //滑动开始
      onPanStart: (DragStartDetails details) {
        //强制停止上一个动画
        _animationController.stop(canceled: true);
      },
      //滑动更新
      onPanUpdate: (DragUpdateDetails details) {
        _dragAlignment += Alignment(
          details.delta.dx / size.width*2,
          details.delta.dy / size.height*2,
        );
      },


      //滑动结束
      onPanEnd: (DragEndDetails details) {},
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}
