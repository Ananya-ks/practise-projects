import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List listToDo = [];
  final _myBox = Hive.box("todobox");

// run 1st time, for ever first time
  void createInitialdata() {
    listToDo = [
      ['Flutter', 'Mobile development app', true],
      ['React', 'Web development', false],
      ['JS', 'basic of all', true],
    ];
  }

  //load data
  void loadData() {
    listToDo = _myBox.get("todobox");
  }
  /// update the data
  void updatData() {
    _myBox.put("todobox", listToDo);
  }
}
