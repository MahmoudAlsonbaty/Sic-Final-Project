import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app_2024/Presentation/Screens/ToDoScreen/ToDoScreen.dart';
import 'package:to_do_app_2024/Presentation/UI_Consts.dart';

late final Box todoBox;
Future<void> main() async {
  await Hive.initFlutter();
  todoBox = await Hive.openBox('todo');
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      theme: ThemeData(
        brightness: Brightness.light,
        // textTheme: GoogleFonts.robotoTextTheme(),
        primaryColor: myColors().primaryColor,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(myColors().accentColor),
        ),
        useMaterial3: true,
      ),
      home: ToDoPage(
        title: 'TO DO',
        todoBox: todoBox,
      ),
    );
  }
}
