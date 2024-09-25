import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app_2024/Presentation/UI_Consts.dart';

class ToDoTile extends StatelessWidget {
  final String title;
  final bool isDone;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? onDeleted;
  const ToDoTile(
      {super.key,
      required this.title,
      required this.isDone,
      required this.onChanged,
      required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              label: 'Delete',
              backgroundColor: Colors.red,
              icon: Icons.delete,
              onPressed: onDeleted,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: myColors().secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Checkbox(value: isDone, onChanged: onChanged),
              Text(
                title,
                style: TextStyle(
                    fontSize: 17,
                    decoration: isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
