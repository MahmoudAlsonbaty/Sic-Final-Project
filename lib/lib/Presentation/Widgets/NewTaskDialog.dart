import 'package:flutter/material.dart';
import 'package:to_do_app_2024/Presentation/UI_Consts.dart';

class NewTaskDialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;
  const NewTaskDialogBox({
    super.key,
    required this.controller,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: myColors().secondaryColor,
        content: Container(
          height: 250,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: myColors().secondaryColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: "Enter Task",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: myColors().accentColor, width: 5),
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              myColors().accentColor)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        controller.clear();
                      },
                      child: Text("Cancel")),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              myColors().accentColor)),
                      onPressed: onAdd,
                      child: Text("Add")),
                ],
              )
            ],
          ),
        ));
  }
}
