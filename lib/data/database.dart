import 'package:hive_flutter/hive_flutter.dart';
class ToDoDataBase {
  List toDoList = [];

  final _myBox = Hive.box('mybox');
  // yo chai initial data haru hun
  void createInitialData(){
    toDoList = [
      ['Pani Kha', false],
      ['Khana Paka', false],
    ];
  }

// database bata data load garne
  void loadData(){
    toDoList = _myBox.get('TODOLIST');
  }

  // update the database
  void updateDataBase(){
    _myBox.put('TODOLIST', toDoList);
  }
}