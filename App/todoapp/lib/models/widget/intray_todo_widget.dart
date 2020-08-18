import 'package:flutter/material.dart';
import 'package:todoapp/models/global.dart';

class IntrayToDo extends StatelessWidget {
  final String title;
  final String keyValue;
  IntrayToDo({this.keyValue, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(keyValue),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      height: 100,
      decoration: BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Radio(),
          Column(
            children: <Widget>[
              Text(title, style: darkTodoTitle),
            ],
          ),
        ],
      ),
    );
  }
}

class MoveableStackItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoveableStackItemState();
  }
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  double yPosition = 0;
  Color color;
  @override
  void initState() {
    color = redColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            yPosition += tapInfo.delta.dy;
          });
        },
        child: Container(
          width: 150,
          height: 150,
          color: color,
        ),
      ),
    );
  }
}
