import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoPage extends StatelessWidget {
  final String taskTitle;
  final String taskContent;
  final bool status;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  ToDoPage({
    super.key,
    required this.taskTitle,
    required this.taskContent,
    required this.status,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade900,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Column(
              children: [
                Slidable(
                  endActionPane: ActionPane(motion: StretchMotion(), children: [
                    SlidableAction(
                      onPressed: deleteFunction,
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ]),
                  child: Container(
                      width: 500.0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      decoration: BoxDecoration(color: Colors.deepPurple[400]),
                      child: Row(
                        children: [
                          Checkbox(
                            value: status,
                            onChanged: onChanged,
                            activeColor: Colors.black,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                taskTitle,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    decoration: status
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                taskContent,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  decoration: status
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
