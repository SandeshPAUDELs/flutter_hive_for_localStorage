import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListTilee extends StatelessWidget {

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ListTilee({super.key, required this.taskName, required this.deleteFunction, required this.onChanged, required this.taskCompleted});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8),
    child: Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: [
        SlidableAction(onPressed: deleteFunction,
        icon: Icons.delete,
        backgroundColor: Colors.red,
        borderRadius: BorderRadius.circular(8),
        
        )
      ]), child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Checkbox(value: taskCompleted, onChanged: onChanged, activeColor: Colors.black,),
            Text(taskName, style: TextStyle(
              decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none
            ))

          ]
        )
      ),
    )

    );
  }
}