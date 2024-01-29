import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hieve_storage/data/database.dart';
import 'package:hieve_storage/utils/list_tile.dart';
import 'package:hieve_storage/utils/my_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  void initState(){
    if(_myBox.get('TODOLIST') == null){
      db.createInitialData();
    }
    else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void SaveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add To Do here'),
          content: Column(
            children: [
              TextField(
                controller: _controller, // Pass the controller here
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add To do here',
                ),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: SaveNewTask, // Call SaveNewTask method on press
              child: Text('Save'),
            ),
            OutlinedButton(
              onPressed: (){
                Navigator.of(context).pop();
                _controller.clear();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To do')),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask, // Call createNewTask method on press
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ListTilee(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
