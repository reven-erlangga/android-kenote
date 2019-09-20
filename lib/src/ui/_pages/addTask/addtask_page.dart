import 'package:flutter/material.dart';
import 'package:kenote/src/helper/database_helper.dart';
import 'package:kenote/src/models/task_model.dart';
import 'package:kenote/src/ui/_layout/appbar_layout.dart';
import 'package:kenote/src/widget/button_widget.dart';

class AddTask extends StatefulWidget {
  final Task note;
  final String appbarTitle;
  AddTask(this.note, this.appbarTitle);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DatabaseHelper db = new DatabaseHelper();

  // Deklarasi variabel
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    // Controller
    titleController = new TextEditingController(text: widget.note.title);
    descriptionController = new TextEditingController(text: widget.note.description);
  }

  // Back button callback
  void backFunction(){
    Navigator.of(context).pop(true);
  }

  // Add task callback
  void _addTask() async {
    if (widget.note.id != null) {
      db.updateNote(Task.fromMap({
        'id': widget.note.id,
        'title': titleController.text,
        'description': descriptionController.text
      })).then((_) {
        Navigator.pop(context, 'update');
      });
    }else {
      db.saveNote(Task(titleController.text, descriptionController.text)).then((_) {
        Navigator.pop(context, 'save');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode); // untuk memunculkan focus node nya
    return Scaffold(
      appBar: appbarLayout(backFunction, Icons.arrow_back_ios, widget.appbarTitle),
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: TextField(
                controller: titleController,
                focusNode: focusNode,
                cursorColor: const Color.fromARGB(255, 254, 100, 110),
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Lustria',
                      color: const Color.fromARGB(255, 254, 100, 110)
                    ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                cursorColor: const Color.fromARGB(255, 254, 100, 110),
                maxLines: null,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lustria',
                ),
                decoration: InputDecoration(
                  hintText: 'Add your task',
                  border: InputBorder.none
                ),
              ),
            ),
          ],
        )
      ),
      floatingActionButton: addFabButton(Icons.create, 'Add Task', _addTask),
    );
  }
}