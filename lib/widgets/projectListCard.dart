import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_webapp/providers/projects.dart';
import 'package:realtime_webapp/screens/addTaskScreen.dart';
import 'package:realtime_webapp/screens/assignEmployeeScreen.dart';

import 'package:realtime_webapp/services/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'loading.dart';

class ProjectListCard extends StatefulWidget {
  ProjectListCard({Key key}) : super(key: key);

  @override
  _ProjectListCardState createState() => _ProjectListCardState();
}

class _ProjectListCardState extends State<ProjectListCard> {
  List<Projects> _projects;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getAllProjects().then((value) {
        _projects = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Services service = Provider.of<Services>(context, listen: true);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: 1200,
            height: 800,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Text("List of Projects",
                        style: TextStyle(
                            color: HexColor("#222C4A"),
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Card(
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 15,
                              color: HexColor("#222C4A"),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: FutureBuilder(
                            future: service.getEmployees(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Loading();
                              } else
                                return Container(
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(),
                                    shrinkWrap: true,
                                    reverse: true,
                                    primary: false,
                                    itemCount: _projects != null
                                        ? _projects.length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Container(
                                          child: ListTile(
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    '${_projects[index].toString()}'),
                                              ),
                                              leading: Container(
                                                width: 60,
                                                height: 60,
                                                color: Colors.red,
                                                child: RaisedButton.icon(
                                                  color: HexColor("#222C4A"),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AssignEmployeeScreen(
                                                                  projectId: _projects[
                                                                          index]
                                                                      .projectId)),
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.person_add,
                                                    color: Colors.white,
                                                  ),
                                                  label: Text(""),
                                                ),
                                              ),
                                              trailing: Container(
                                                width: 150,
                                                height: 250,
                                                color: Colors.red,
                                                child: RaisedButton.icon(
                                                    color: HexColor("#222C4A"),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddTaskScreen(
                                                                  projectId: _projects[
                                                                          index]
                                                                      .projectId,
                                                                  projectName:
                                                                      _projects[
                                                                              index]
                                                                          .name,
                                                                )),
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                    label: Text(
                                                      "Manage tasks",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                );
                            },
                          )),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/addProject');
                      },
                      color: HexColor("#222C4A"),
                      child: Text(
                        "Add Project",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
