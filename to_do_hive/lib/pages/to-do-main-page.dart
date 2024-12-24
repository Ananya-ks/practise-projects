import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_hive/data/database.dart';
import 'package:to_do_hive/pages/dialog_box.dart';
import './to-do-page.dart';
import './my_toast.dart';

class ToDoMainPage extends StatefulWidget {
  const ToDoMainPage({super.key});

  @override
  State<ToDoMainPage> createState() => _ToDoMainPageState();
}

class _ToDoMainPageState extends State<ToDoMainPage> {
  final _titlecontroller = TextEditingController();
  final _contentcontroller = TextEditingController();
  //refernce box
  final _mybox = Hive.box('todobox');
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
    if (_mybox.get('todobox') == null) {
      db.createInitialdata();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChange(bool? status, int index) {
    setState(() {
      db.listToDo[index][2] = !db.listToDo[index][2];
    });
    db.updatData();
  }

  void saveNewTask(String newstatus) {
    if ((_titlecontroller.text.isNotEmpty) &&
        (_contentcontroller.text.isNotEmpty)) {
      setState(() {
        db.listToDo.add([
          _titlecontroller.text,
          _contentcontroller.text,
          newstatus == "Completed"
        ]);
      });

      _titlecontroller.clear();
      _contentcontroller.clear();

      db.updatData();

      Navigator.of(context).pop();
    } else if (_titlecontroller.text.isEmpty &&
        _contentcontroller.text.isEmpty) {
      NewToast.show('Title and content are required');
    } else if (_titlecontroller.text.isEmpty) {
      NewToast.show('Title is required');
    } else if (_contentcontroller.text.isEmpty) {
      NewToast.show('Content is required');
    }
  }

  void createNewtask() {
    showDialog(
      //RHS context refers to location of showDialog() call in widget tree. It ensures dialog is placed correctly
      // and access to apprpriate ancestors and inherited widgets.
        context: context,
        builder: (context) {
          return DialogBox(
            titlecontroller: _titlecontroller,
            contentcontroller: _contentcontroller,
            onSave: saveNewTask,
            onCancel: () {
              Navigator.pop(context);
              _titlecontroller.clear();
              _contentcontroller.clear();
            },
          );
        });
    db.updatData();
  }

  void deletetask(int index) {
    setState(() {
      db.listToDo.removeAt(index);
    });
    db.updatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      // appBar: AppBar(title: Text('To-Do'),),


      //listview.Builder -> takes the list and builds new widgets for those lists
      body: ListView.builder(
          itemCount: db.listToDo.length,
          itemBuilder: (context, index) {
            return ToDoPage(
                taskTitle: db.listToDo[index][0],
                taskContent: db.listToDo[index][1],
                status: db.listToDo[index][2],
                onChanged: (status) => checkBoxChange(status, index),
                deleteFunction: (context) => deletetask(index));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewtask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
