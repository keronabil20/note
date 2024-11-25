import 'package:flutter/material.dart';
import 'package:to_do_app/components/constants.dart';
import 'package:to_do_app/components/reusable_components.dart';

class NewTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context,index)=>buildTaskItem(tasks [index]), separatorBuilder: (context,index)=>Container(
      height: 1,
      color: Colors.green[200],
      width: double.infinity,
    ), itemCount: tasks.length);
  
  }
}