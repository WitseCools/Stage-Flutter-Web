import 'package:flutter/material.dart';
import 'package:realtime_webapp/widgets/addTaskCard.dart';

import 'package:hexcolor/hexcolor.dart';

class AddTaskScreen extends StatefulWidget {
  String projectId;
  String projectName;
  AddTaskScreen({Key key, this.projectId, this.projectName}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        backgroundColor: HexColor("#222C4A"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: AddTaskCard(
            projectId: widget.projectId,
            projectName: widget.projectName,
          ),
        ),
      ),
    );
  }
}
