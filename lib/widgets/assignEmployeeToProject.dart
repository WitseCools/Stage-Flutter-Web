import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:realtime_webapp/providers/employee.dart';
import 'package:realtime_webapp/providers/employees.dart';
import 'package:realtime_webapp/providers/projects.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:realtime_webapp/widgets/loading.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class AssignEmployeeToProject extends StatefulWidget {
  String projectId;
  AssignEmployeeToProject({Key key, this.projectId}) : super(key: key);

  @override
  _AssignEmployeeToProjectState createState() =>
      _AssignEmployeeToProjectState();
}

List<Employees> _employees = [];
List<Projects> _projects = [];
Employees selectedEmployee;

class _AssignEmployeeToProjectState extends State<AssignEmployeeToProject> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getEmployees().then((value) {
        print(value.length);
        _employees = value;
      });
      service.getAllProjects().then((value) => {_projects = value});
    });
  }

  void _submit(String selectedEmployeeId) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.assignEmployee(selectedEmployeeId, widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    Services services = Provider.of<Services>(context, listen: false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 15,
              color: HexColor("#222C4A"),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: 700,
          height: 520,
          child: SingleChildScrollView(
            child: Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Assign an employee",
                      style: TextStyle(
                          color: HexColor("#222C4A"),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                  future: services.getEmployees(),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (!snapshot.hasData) {
                                      return Loading();
                                    } else
                                      return SearchableDropdown(
                                        items: _employees.map((item) {
                                          return new DropdownMenuItem<
                                                  Employees>(
                                              child: Text(item.firstName),
                                              value: item);
                                        }).toList(),
                                        isExpanded: true,
                                        label: "Select an employee",
                                        menuConstraints: BoxConstraints.tight(
                                            Size.fromHeight(250)),
                                        value: selectedEmployee,
                                        dialogBox: false,
                                        isCaseSensitiveSearch: true,
                                        searchHint: new Text(
                                          'Select an employee ',
                                          style: new TextStyle(fontSize: 20),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedEmployee = value;
                                          });
                                        },
                                      );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () {
                                _submit(selectedEmployee.employeeId);
                                Navigator.of(context).pop();
                              },
                              color: HexColor("#222C4A"),
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
