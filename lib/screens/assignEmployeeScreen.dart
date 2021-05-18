import 'package:flutter/material.dart';
import 'package:realtime_webapp/widgets/assignEmployeeToProject.dart';

import 'package:hexcolor/hexcolor.dart';

class AssignEmployeeScreen extends StatefulWidget {
  String projectId;
  AssignEmployeeScreen({Key key, this.projectId}) : super(key: key);

  @override
  _AssignEmployeeScreenState createState() => _AssignEmployeeScreenState();
}

class _AssignEmployeeScreenState extends State<AssignEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Project"),
        backgroundColor: HexColor("#222C4A"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: AssignEmployeeToProject(projectId: widget.projectId),
        ),
      ),
    );
  }
}
