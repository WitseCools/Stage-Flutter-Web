import 'package:flutter/material.dart';
import 'package:realtime_webapp/widgets/projectListCard.dart';

class ProjectListScreen extends StatefulWidget {
  ProjectListScreen({Key key}) : super(key: key);

  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: ProjectListCard());
  }
}
