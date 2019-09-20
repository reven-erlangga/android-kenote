import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kenote/src/animations/slide_right_animation.dart';
import 'package:kenote/src/helper/database_helper.dart';
import 'package:kenote/src/models/task_model.dart';
import 'package:kenote/src/ui/_layout/appbar_layout.dart';
import 'package:kenote/src/ui/_pages/addTask/addtask_page.dart';
import 'package:kenote/src/widget/button_widget.dart';
import 'package:kenote/src/widget/cardlist_widget.dart';

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  ScrollController _scrollController; //Deklarasi scrollcontroller
   List<Task> items = List();
  DatabaseHelper db = DatabaseHelper();
  Task task;
  
  @override
  void initState() {
    super.initState();

    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Task.fromMap(note));
        });
      });
    });
  }

  // Pergi ke halaman tambah catatan
  _createNewNote() async {
    print('Navigasi ke new task');
    var result = await Navigator.push(
      context, 
      SlideRightRoute(
        page:  AddTask(Task('', ''), "New Task")
      )
    );
 
    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Task.fromMap(note));
          });
        });
      });
    }
  }
    
  void _deleteNote(BuildContext context, Task note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
 
  void _navigateToNote(BuildContext context, Task note) async {
    print('Navigasi ke edit task');
    var result = await Navigator.push(
      context, 
      SlideRightRoute(
        page:  AddTask(note, "Edit Task")
      )
    );
 
    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Task.fromMap(note));
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              sliverappbarLayout(null, null, 'All Task', MediaQuery.of(context).size.height - 500),
            ];
          },
          body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 9,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index){
                      return Slidable.builder(
                          key: Key(UniqueKey().toString()), 
                          actionPane: SlidableStrechActionPane(),
                          actionExtentRatio: 0.25,
                          dismissal: SlidableDismissal(
                            child: SlidableDrawerDismissal(),
                            onDismissed: (actionType) => _deleteNote(context, items[index], index),
                          ),
                          child: Container(
                            height: 150,
                            child: Card(
                              elevation: 0.0,
                              child: InkWell(
                                onTap: () => _navigateToNote(context, items[index]),
                                child: listTile(items[index].title, items[index].description),
                              ),
                            )
                          ),
                          secondaryActionDelegate: SlideActionBuilderDelegate(
                            actionCount: 1,
                            builder: (context, index, animation, renderingMode){
                              return IconSlideAction(
                                caption: 'Delete',
                                color: Color.fromARGB(255, 254, 100, 110),
                                icon: Icons.delete,
                                onTap: () async {
                                  print ("tapped");
                                  var state = Slidable.of(context); //State slidable
                                  state.dismiss();
                                },
                              );
                            }
                          ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: addFabButton(Icons.add, "Add Task",  _createNewNote)
      );
  }
}