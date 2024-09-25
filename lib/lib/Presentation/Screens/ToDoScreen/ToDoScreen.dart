import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app_2024/Presentation/UI_Consts.dart';
import 'package:to_do_app_2024/Presentation/Widgets/NewTaskDialog.dart';
import 'package:to_do_app_2024/Presentation/Widgets/TodoTile.dart';
import 'package:to_do_app_2024/main.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key, required this.title, required this.todoBox});
  final String title;
  final Box todoBox;
  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  TextEditingController controller = TextEditingController();

  List toDoList = [
    ["Bla1", false]
  ];
  @override
  void initState() {
    toDoList = todoBox.get("TODO", defaultValue: [
      ["Bla", false]
    ]);
    super.initState();
  }

  void newTask() {
    showDialog(
        context: context,
        builder: (context) => NewTaskDialogBox(
              controller: controller,
              onAdd: onAdd,
            ));
  }

  void onAdd() {
    setState(() {
      toDoList.add([controller.text, false]);
      controller.clear();
    });
    todoBox.put("TODO", toDoList);
    Navigator.of(context).pop();
  }

  void onDelete(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
    todoBox.put("TODO", toDoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: myColors().secondaryColor,
          title: Center(child: Text(widget.title)),
        ),
        backgroundColor: myColors().primaryColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ListView.builder(
            itemCount: toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                title: toDoList[index][0],
                isDone: toDoList[index][1],
                onChanged: (newVal) {
                  setState(() {
                    toDoList[index][1] = newVal;
                  });
                },
                onDeleted: (BuildContext cntxt) {
                  onDelete(index);
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: newTask,
          child: Icon(Icons.add),
          backgroundColor: myColors().accentColor,
        ));
  }
}
