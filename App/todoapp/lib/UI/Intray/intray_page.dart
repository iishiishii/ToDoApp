import 'package:flutter/material.dart';
import 'package:todoapp/models/global.dart';
import 'package:todoapp/models/widget/intray_todo_widget.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<IntrayToDo> todoItem = [];
  @override
  Widget build(BuildContext context) {
    todoItem = getList();
    return Container(
      color: darkGreyColor,
      child: _buildReorderableListSimple(context),
      // child: ReorderableListView(
      //   padding: EdgeInsets.only(top: 140),
      //   children: todoItem,
      //   onReorder: _onReorder,
      // ),
    );
  }

  Widget _buildListTile(BuildContext context, IntrayToDo item) {
    return ListTile(
      key: Key(item.keyValue),
      title: item,
    );
  }

  Widget _buildReorderableListSimple(BuildContext context) {
    return ReorderableListView(
      // handleSide: ReorderableListSimpleSide.Right,
      // handleIcon: Icon(Icons.access_alarm),
      padding: EdgeInsets.only(top: 300.0),
      children: todoItem
          .map((IntrayToDo item) => _buildListTile(context, item))
          .toList(),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          IntrayToDo item = todoItem[oldIndex];
          todoItem.remove(item);
          todoItem.insert(newIndex, item);
        });
      },
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final IntrayToDo item = todoItem.removeAt(oldIndex);
      todoItem.insert(newIndex, item);
    });
  }

  List<Widget> getList() {
    for (int i = 0; i < 10; i++) {
      todoItem.add(IntrayToDo(keyValue: i.toString(), title: "Hello"));
    }
    return todoItem;
  }
}
